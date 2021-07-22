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

usage_msg = "Usage: #{__FILE__} <input.csv> (v1|v2)"

if ARGV.length != 2
  puts usage_msg
  Kernel.exit(1)
end

config =
  if ARGV[1] == "v1"
    puts "TODO: set up config for fluxv1 bug scrub tenant"
    Kernel.exit(1)
    # fill out this template with the structure from a prior Flux v1 worksheet:
    {
      google_sheet_id:   "",
      scrub_event_id:    "",
      previous_event_id: "",
      csvinput_filename: ARGV[0]
    }
  elsif ARGV[1] == "v2"
    {
      google_sheet_id:   "1rJ994hMfZZr1ehjpFeZ4HJiPNOHmpnAIFqURR_-WY7A",
      scrub_event_id:    "0004",
      previous_event_id: "0003",
      csvinput_filename: ARGV[0]
    }
  else
    puts usage_msg
    Kernel.exit(1)
  end

o = BugCrush::Spreadsheet.new(**config)

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
