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
        new_ws: new_worksheet[:ws],
        spreadsheet_id: id
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

        holding_tank[key(row)] = row
      end

      new_ws.rows.each_with_index do |row, index|
        next if index == 0
        matching_row = holding_tank[key(row)]

        if matching_row.present?
          new_ws[index + 1, 12] = matching_row[11]
          new_ws[index + 1, 14] = matching_row[13]
          new_ws[index + 1, 16] = matching_row[15]
          new_ws[index + 1, 17] = matching_row[16]
        end
      end

      new_ws.save

      # add the locked row to the top of the sheet
      spreadsheet = self[:session].spreadsheet_by_key(self[:spreadsheet_id])
      spreadsheet.batch_update(
        [ { update_sheet_properties:
            {
              fields: "gridProperties.frozenRowCount",
              properties:
              {
                sheet_id: new_ws.sheet_id,
                grid_properties: {
                  frozen_row_count: 1
                }
              }
            }
        } ] )
      new_ws.reload

      rescue AlreadyDid
        return false # failure
      end

      return true
    end
    private

    def key(row)
      row[0..2].join('|')
    end
  end
end
