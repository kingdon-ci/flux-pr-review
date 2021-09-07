require './lib/bug_crush/discussions'
require 'pry'

d = BugCrush::Discussions.new

a = d.discussions

header = "Repository,Type,#,User,Title,State,Created,Updated,Merged,URL"
puts header
a.each do |row|
  puts row.to_csv
end

puts "tests OK"
# binding.pry
