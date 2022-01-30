# typed: strict
require 'forwardable'

module BugCrush
  class CopyState
    extend Forwardable
    def_delegators :@properties, :[], :[]=

    def initialize(new_worksheet:)
      session = new_worksheet[:session]
      id = new_worksheet[:spreadsheet_id]

      @name = new_worksheet[:spreadsheet][:previous_event_id]
      old_worksheet = session.
        spreadsheet_by_key(id).worksheet_by_title(@name)

      @properties = {
        session: session,
        old_ws: old_worksheet,
        new_ws: new_worksheet[:ws]
      }
    end

    def old_ws
      self[:old_ws]
    end

    def new_ws
      self[:new_ws]
    end

    def check_for_safety!
      rows = new_ws.num_rows
      if new_ws[2, 12] == '' && new_ws[2, 14] == '' &&
          new_ws[2, 16] == '' && new_ws[2, 17] == '' &&
          new_ws[rows, 12] == '' && new_ws[rows, 14] == '' &&
          new_ws[rows, 16] == '' && new_ws[rows, 17] == ''
        # safe to proceed
      else
        raise AlreadyDid, "whatever losers"
      end
    end

    def call
      begin
        check_for_safety!

      holding_tank = {}

      old_ws.rows.each_with_index do |row, index|
        next if index == 0
        key = row[2]
        binding.pry if key == "282"
        holding_tank[key] = row
      end
      binding.pry

      new_ws.rows.each_with_index do |row, index|
        next if index == 0
        matching_row = holding_tank[row[2]]

        if matching_row.present?
          new_ws[index + 1, 12] = matching_row[11]
          new_ws[index + 1, 14] = matching_row[13]
          new_ws[index + 1, 16] = matching_row[15]
          new_ws[index + 1, 17] = matching_row[16]
        end
      end

      new_ws.save

      rescue AlreadyDid
        return false # failure
      end

      return true
    end
  end
end
