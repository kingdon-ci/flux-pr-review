require './lib/bug_crush/discussions'
require 'pry'

d = BugCrush::Discussions.new

a = d.discussions
binding.pry
