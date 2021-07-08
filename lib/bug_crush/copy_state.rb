# typed: strict
require 'forwardable'

module BugCrush
  class CopyState
    extend Forwardable
    def_delegators :@properties, :[], :[]=

    def initialize(spreadsheet:, new_worksheet:)
      session = spreadsheet[:session]
      id = spreadsheet.spreadsheet_id

    end
  end
end
