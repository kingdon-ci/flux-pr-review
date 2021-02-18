require 'forwardable'
require 'csv'

module PutIn
  class AlreadyDid < StandardError; end
  class Spreadsheet
    extend Forwardable
    def_delegators :@properties, :[], :[]=

    def initialize(config_json: "config.json", spreadsheet_id:, input_file: 'pr.csv')
      @spreadsheet_id = spreadsheet_id
      session = GoogleDrive::Session.from_config(config_json)

      @properties = {
        session: session,
        ws: session.spreadsheet_by_key(spreadsheet_id).worksheets[0],
        input_filename: input_file,
        spreadsheet_id: spreadsheet_id
      }

      self[:pr_csv] = CSV.read(input_filename)

      begin
        check_for_safety!
        call
      rescue AlreadyDid
        # already did this part, signaled by check_for_safety!
      end
    end

    def ws
      self[:ws]
    end

    def input_csv
      self[:pr_csv]
    end

    def input_filename
      self[:input_filename]
    end

    def spreadsheet_id
      self[:spreadsheet_id]
    end

    def call
      num_rows, num_cols = input_csv.length, input_csv[0].length

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

      ws.save
    end

    def check_for_safety!
      if ws[1, 1] == '' && ws[2, 1] == ''
        # it is probably safe to proceed, there is no data in the worksheet to
        # overwrite
      else
        raise AlreadyDid, "worksheet already has data, cowardly aborting"
      end
    end
  end
end
