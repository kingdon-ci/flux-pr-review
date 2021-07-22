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
  new(google_sheet_id: "1rJ994hMfZZr1ehjpFeZ4HJiPNOHmpnAIFqURR_-WY7A",
      scrub_event_id: "0003", previous_event_id: "0002")

success = o.call

if success
  w = BugCrush::Worksheet.
    new(spreadsheet: o, new_worksheet_label: "0003")
  success = w.call
else
  puts "Error during BugCrush::Spreadsheet.call"
  puts "hint: will not overwrite the Scratch sheet, select all and delete everything to proceed"
  Kernel.exit(1)
end

if success
  n = BugCrush::CopyState.
    new(new_worksheet: w)
  success = n.call
else
  puts "Error during BugCrush::Worksheet.call"
  puts "hint: create a new worksheet, copy the header row, and update the config to proceed"
  Kernel.exit(1)
end

if success
  puts "Success, go visit the spreadsheet"
else
  puts "Error during BugCrush::CopyState.call"
  puts "hint: there be dragons, (now go write the rest of the method)"
  Kernel.exit(1)
end
