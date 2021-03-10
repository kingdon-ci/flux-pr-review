require 'forwardable'

module Make
  class InvalidHeader < StandardError; end
  class AlreadyDid < StandardError; end
  class Worksheet
    extend Forwardable
    def_delegators :@properties, :[], :[]=

    def initialize(first_spreadsheet:,
      second_sheet_label: "Mar pr (state copy-to)")
      session = first_spreadsheet[:session]
      id = first_spreadsheet.spreadsheet_id

      @properties = {
        session: session,
        ws: session.spreadsheet_by_key(id).worksheets[1],
        first_spreadsheet: first_spreadsheet,
        spreadsheet_id: id
      }
      @name = second_sheet_label

      begin
        check_for_safety!
        call
      rescue AlreadyDid
      end
    end

    def ws
      self[:ws]
    end

    def first_spreadsheet
      self[:first_spreadsheet].ws
    end

    def sheet_name
      @name
    end

    def call
      (1..first_spreadsheet.num_rows).each do |y|
        next if y == 1

        (1..8).each do |x|
          ws[y, x] = first_spreadsheet[y, x]
        end

        begin
          stale_age = %Q|=LOG10((J#{y}+1)*(K#{y}+1))| # (derived) Stale-Age
          ws[y, 9] = stale_age
          days_age = Date.today - Date.parse(ws[y, 7]) # Created Date
          ws[y, 10] = days_age.to_i
          days_stale = Date.today - Date.parse(ws[y, 8]) # Updated Date
          ws[y, 11] = days_stale.to_i
        rescue Date::Error => e
          # binding.pry
        end
        ws[y, 12] = '' # Recommend Action - this is blank for now
        ws[y, 13] = first_spreadsheet[y, 9] # URL
        ws[y, 14] = '' # Read yet?
        ws[y, 15] = %Q|=HYPERLINK(M#{y}, REPLACE(M#{y}, 1, 31, ""))| # Link
        ws[y, 16] = '' # Comment
        ws[y, 17] = '' # Flag
      end
      ws.save
    end

    def header
      [ "Repository", "Type", "#", "User", "Title", "State", "Created", "Updated", "Stale-Age", "Days-Age", "Days-Stale", "Recommend Action", "URL", "Read yet?", "Link", "Comment", "Flag" ]
    end

    def check_sheet_name!
      actual_title = ws.title
      unless actual_title == sheet_name
        raise InvalidHeader, "expected sheet name to match #{sheet_name} but it was #{actual_title}"
      end
      true
    end

    def check_header!
      actual_header = ws.rows.first
      unless actual_header == header
        raise InvalidHeader, "expected header to match #{header} but it was #{actual_header}"
      end
      true
    end

    def check_for_safety!
      if check_sheet_name! && check_header! &&
        ws[2, 1] == '' && ws[3, 1] == ''
        # it is probably safe to proceed, there is no data in the worksheet to
        # overwrite
      else
        raise AlreadyDid, "worksheet already has data, cowardly aborting"
      end
    end
  end
end
