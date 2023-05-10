require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

# creates a new Cucumber::Rake::Task with the name :features.
# This task is responsible for running the feature files defined
# in the project's features directory.
Cucumber::Rake::Task.new(:features) do |t|
  t.profile = 'default'
end

task :default => :features
