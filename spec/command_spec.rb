require File.join(File.dirname(__FILE__), 'spec_helper')

describe Syscmd::Command, ".new" do
  subject { Syscmd::Command.new(TESTER) }
  
  it "should have #{TESTER} as cmd attribute" do
    subject.cmd.should == TESTER
  end
  
  it "should not be executed after creation" do
    subject.executed?.should == false
  end
end

describe Syscmd::Command, ".new with -s 'Hello World'" do
  subject { Syscmd::Command.new(TESTER, '-s', 'Hello World') }
  
  it "should have the cmd attribute #{TESTER}" do
    subject.cmd.should == TESTER
  end
  
  it "should have the command line arguments ['-s', 'Hello World']" do
    subject.args.should == ['-s', 'Hello World']
  end
  
  it "should have the command line '#{TESTER} -s \"Hello World\"'" do
    subject.cmdline.should == "#{TESTER} -s \"Hello World\""
  end
end
