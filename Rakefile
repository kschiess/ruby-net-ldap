require "rubygems"
require "rake/rdoctask"
require 'rake/testtask'
require 'rspec/core/rake_task'
require "rake/gempackagetask"

desc "Run all specs."
RSpec::Core::RakeTask.new

desc "Run all tests."
Rake::TestTask.new do |t|
  t.libs = %w(lib test)
end

task :default => :spec

require 'sdoc'

# This task actually builds the gem. 
task :gem => :spec
spec = eval(File.read('net-ldap.gemspec'))

desc "Generate the gem package."
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end