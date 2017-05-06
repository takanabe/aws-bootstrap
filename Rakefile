require "bundler/gem_tasks"
require "rspec/core/rake_task"
require './rake_helper'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc "Create a rds with option yaml"
task :create_rds do
  create_rds(load_options)
end
