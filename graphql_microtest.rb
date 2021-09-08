require './lib/bug_crush/discussions'
require 'pry'

d = BugCrush::Discussions.new

a = d.discussions

csv_output = a.to_csv
File.write("discussions.csv", csv_output)

puts "tests OK"
# binding.pry
