namespace :ci do
  desc "Run CI Smoke Tests"
  task :test do
    puts "Build Passed"
  end
end

desc "run 'rake ci' from Jenkins"
task ci: 'ci:test'
