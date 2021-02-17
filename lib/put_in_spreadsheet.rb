require 'forwardable'

module PutIn
  class Spreadsheet
    extend Forwardable
    def_delegators :@properties, :[]

    def initialize(config_json: "config.json", spreadsheet_id:)
      @spreadsheet_id = spreadsheet_id
      session = GoogleDrive::Session.from_config(config_json)

      @properties = {
        session: session,
        ws: session.spreadsheet_by_key(spreadsheet_id).worksheets[0]
      }

      call
    end

    def ws
      self[:ws]
    end

    def call
      if ws[1, 1] == '' && ws[2, 1] == ''
        binding.pry
      else
        raise StandardError, "worksheet already has data, cowardly aborting"
      end
    end
  end
end
