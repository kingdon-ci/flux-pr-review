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

usage_msg = "Usage: #{__FILE__} <notused.csv> v2 <notused2.csv>
The v2 sheet target is reset so it can be used for another iteration"

if ARGV.length != 3
  puts usage_msg
  Kernel.exit(1)
end

config =
  # if ARGV[1] == "v1"
  #   {
  #     google_sheet_id:   "1DBpqlv36PwQu5-QlY24S2XDkEnkxWWxo46igMtBiwAo",
  #     scrub_event_id:    "Q3 (0001)",
  #     previous_event_id: "Q2 (Final)",
  #     csvinput_filename: ARGV[0]
  #   }
  # elsif ARGV[1] == "v2"
  {
      google_sheet_id:   "1OXf_liOaUAyEv9EZlfXcHLA5jRdq-ownqGzyLTXeCNo",
      scrub_event_id:    "0042", # FIXME: these should read from bugcrush.rb
      previous_event_id: "0040",
      csvinput_filename: ARGV[0],
      discussion_csvinput_filename: ARGV[2],
    }
  # else
  #   puts usage_msg
  #   Kernel.exit(1)
  # end

o = BugCrush::Spreadsheet.new(**config)
success = o.revert

w = BugCrush::Worksheet.
  new(spreadsheet: o, new_worksheet_label: config[:scrub_event_id])
success2 = w.revert

if success && success2
  puts "Success, progress was hollowed out and reverted"
elsif !success
  puts "Error during BugCrush::Spreadsheet.revert"
  puts "hint: absolutely no idea what could have gone wrong here"
  Kernel.exit(1)
elsif !success2
  puts "Error during BugCrush::Worksheet.revert"
  puts "hint: absolutely no idea what could have gone wrong here"
  Kernel.exit(1)
end
