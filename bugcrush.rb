#!/usr/bin/env ruby
#
#

require "bundler"
Bundler.require(:default)
# require "google_drive"

require './lib/bug_crush'
# require './lib/put_in_spreadsheet'
# require './lib/make_worksheet'
# require './lib/make_copy_state'

o = BugCrush::Spreadsheet.
  new(google_sheet_id: "XXXX", scrub_event_id: "0001", previous_event_id: nil)

o.call

# m = Make::Worksheet.new(first_spreadsheet: o)
# d = Make::CopyState.new(new_worksheet: m)

# end