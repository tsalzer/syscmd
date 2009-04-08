require File.join(File.dirname(__FILE__), 'spec_helper')
require 'spec_helper'

describe "Test Setup" do
  it "should have TESTER == ./spec/tester.rb" do
    TESTER.should == './spec/tester.rb'
  end
end

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

describe Syscmd::Command, ".exec! for -s 'Hello World'" do
  subject { Syscmd::Command.new(TESTER, '-s', 'Hello World') }
  
  it "should have stdout 'Hello World'" do
    subject.exec!.stdout.should == 'Hello World'
  end
  
  it "should have stderr \"\"" do
    subject.exec!.stderr.should == ""
  end
  
  it "should have exitcode 0" do
    pending "exitcode still not set" do
      subject.exec!.exitcode.should == 0
    end
  end
end
