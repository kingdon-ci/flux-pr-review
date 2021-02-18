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
      binding.pry
    end
  end
end
