require 'forwardable'

module Make
  class CopyState
    extend Forwardable
    def_delegators :@properties, :[], :[]=

    def initialize(new_worksheet:,
      old_sheet_label: "Jan pr with fixed dates")
      session = new_worksheet[:session]
      id = new_worksheet[:spreadsheet_id]

      @properties = {
        session: session,
        old_ws: session.spreadsheet_by_key(id).worksheets[3],
        new_ws: new_worksheet[:ws]
      }

      check_for_safety!
      call
    end

    def old_ws
      self[:old_ws]
    end

    def new_ws
      self[:new_ws]
    end

    def check_for_safety!
      rows = new_ws.num_rows
      if new_ws[2, 11] == '' && new_ws[2, 13] == '' &&
          new_ws[2, 15] == '' && new_ws[2, 16] == '' &&
          new_ws[rows, 11] == '' && new_ws[rows, 13] == '' &&
          new_ws[rows, 15] == '' && new_ws[rows, 16] == ''
        # safe to proceed
      else
        raise AlreadyDid, "whatever losers"
      end
    end

    def call
      holding_tank = {}

      old_ws.rows.each_with_index do |row, index|
        next if index == 0
        key = row[2]
        holding_tank[key] = row
      end

      new_ws.rows.each_with_index do |row, index|
        next if index == 0
        matching_row = holding_tank[row[2]]

        if matching_row.present?
          new_ws[index + 1, 11] = matching_row[10]
          new_ws[index + 1, 13] = matching_row[12]
          new_ws[index + 1, 15] = matching_row[14]
          new_ws[index + 1, 16] = matching_row[15]
        end
      end

      new_ws.save
    end
  end
end
