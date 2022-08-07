# typed: strict
require 'forwardable'
require 'csv'

module BugCrush
  class AlreadyDid < StandardError; end
  class Spreadsheet
    extend Forwardable
    def_delegators :@properties, :[], :[]=

    def initialize(google_sheet_id:, scrub_event_id:, previous_event_id:, csvinput_filename:, discussion_csvinput_filename: nil)
      @spreadsheet_id = google_sheet_id
      @config = Config.new(input_file: csvinput_filename, discussion_input_file: discussion_csvinput_filename)
      session = GoogleDrive::Session.from_config(@config.config_json)

      @properties = {
        google_sheet_id:   google_sheet_id,
        scrub_event_id:    scrub_event_id,
        previous_event_id: previous_event_id,
        session:           session,
        input_filename:    @config.input_file,
        discussion_input_filename: @config.discussion_input_file,
      }

      @properties[:ws] =
        session.spreadsheet_by_key(spreadsheet_id).worksheet_by_title("Raw data")

      self[:pr_csv] = CSV.read(input_filename)
      self[:disc_csv] = CSV.read(discussion_input_filename)

    end

    def ws
      self[:ws]
    end

    def input_csv
      self[:pr_csv]
    end

    def discussion_csv
      self[:disc_csv]
    end

    def input_filename
      self[:input_filename]
    end

    def discussion_input_filename
      self[:discussion_input_filename]
    end

    def spreadsheet_id
      self[:google_sheet_id]
    end

    def revert
      c = ws.rows.count

      ws.insert_rows(c+1,1)
      ws.delete_rows(1,c)
      ws.save; ws.reload

    end

    def call
      begin
        check_for_safety!

        populate_from_input_csv
  #      populate_discussions(first_row: first_row_to_write_into)

      ws.save

      rescue AlreadyDid
        # already did this part, signaled by check_for_safety!
        return false # failure
      end

      return true # success
    end

    def check_for_safety!
      if ws[1, 1] == '' && ws[2, 1] == ''
        # it is probably safe to proceed, there is no data in the worksheet to
        # overwrite
      else
        raise AlreadyDid, "worksheet already has data, cowardly aborting"
      end
    end

    def populate_from_input_csv
      num_rows, num_cols = input_csv.length, input_csv[0].length
      num_rows2, num_cols2 = discussion_csv.length, discussion_csv[0].length

      (1..num_rows).each do |row|
        (1..num_cols).each do |col|
          # input_csv is zero-indexed arrays so, ...
          input_value = input_csv&.[](row-1)&.[](col-1)

          if input_value.present?
            if col == 7 || col == 8
              begin
                parsed_date =
                  Date.strptime(input_value, "%m/%d/%y %H:%M:%S")
              rescue Date::Error => e
                parsed_date = input_value
              end
              ws[row, col] = parsed_date
            else
              ws[row, col] = input_value
            end
          end
        end
      end

      (2..num_rows2).each do |row|
        (1..num_cols2).each do |col|
          # input_csv is zero-indexed arrays so, ...
          input_value = discussion_csv&.[](row-1)&.[](col-1)

          if input_value.present?
            if col == 7 || col == 8
              begin
                parsed_date =
                  Date.strptime(input_value, "%m/%d/%y %H:%M:%S")
              rescue Date::Error => e
                parsed_date = input_value
              end
              ws[num_rows + row - 1, col] = parsed_date
            else
              ws[num_rows + row - 1, col] = input_value
            end
          end
        end
      end

      return num_rows + num_rows2
    end
  end
end
