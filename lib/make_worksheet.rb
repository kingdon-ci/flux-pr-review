require 'forwardable'

module Make
  class InvalidHeader < StandardError; end
  class AlreadyDid < StandardError; end
  class Worksheet
    extend Forwardable
    def_delegators :@properties, :[], :[]=

    def initialize(first_spreadsheet:,
      second_sheet_label: "Feb pr with fixed dates")
      session = first_spreadsheet[:session]

      @properties = {
        session: session,
        ws: session.spreadsheet_by_key(first_spreadsheet.spreadsheet_id).worksheets[1],
        first_spreadsheet: first_spreadsheet
      }
      @name = second_sheet_label

      check_for_safety!
      call
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
          days_age = Date.today - Date.parse(ws[y, 7])
          ws[y, 9] = days_age.to_i
          days_stale = Date.today - Date.parse(ws[y, 8])
          ws[y, 10] = days_stale.to_i
        rescue Date::Error => e
          binding.pry
        end
        ws[11, y] = '' # Recommend Action
        ws[12, y] = first_spreadsheet[9, y] # URL
      end
      ws.save
    end

    def header
      [ "Repository", "Type", "#", "User", "Title", "State", "Created", "Updated", "Days-Age", "Days-Stale", "Recommend Action", "URL", "Read yet?", "Link", "Comment", "Flag" ]
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
