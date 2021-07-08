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
  new(google_sheet_id: "1viBrqoD6FmYmXDPogrSAVHBccn75lX67GFgaFEcJj1A",
      scrub_event_id: "0002", previous_event_id: "0001")

success = o.call

if success
  w = BugCrush::Worksheet.
    new(spreadsheet: o, new_worksheet_label: "0002")
  success = w.call
else
  puts "Error during BugCrush::Spreadsheet.call"
  Kernel.exit(1)
end

if success
  n = BugCrush::CopyState.
    new(spreadsheet: o,
        new_worksheet: w)
  success = n.call
else
  puts "Error during BugCrush::Worksheet.call"
  Kernel.exit(1)
end

if success
  puts "Success, go visit the spreadsheet"
else
  puts "Error during BugCrush::CopyState.call"
  Kernel.exit(1)
end

# m = Make::Worksheet.new(first_spreadsheet: o)
# d = Make::CopyState.new(new_worksheet: m)

# end
