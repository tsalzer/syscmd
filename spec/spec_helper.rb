require 'spec'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'syscmd'

TESTER=File.join(File.dirname(__FILE__), 'tester.rb') unless defined?(TESTER)

Spec::Runner.configure do |config|
  
end
