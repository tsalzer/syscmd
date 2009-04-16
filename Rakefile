require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "syscmd"
    gem.summary = %Q{Wrapper for OS command execution}
    gem.email = "till.salzer@googlemail.com"
    gem.homepage = "http://github.com/tsalzer/syscmd"
    gem.authors = ["Till Salzer"]

    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

task :default => :spec

desc "run all tests (RSpec with coverage, Cucumber)"
task :test => [:rcov, :features]

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
