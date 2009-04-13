require File.join(File.dirname(__FILE__), 'spec_helper')
require 'spec_helper'

describe Syscmd, ".execute" do
  subject { Syscmd }
  
  it "should provide a .execute method" do
    subject.should respond_to(:exec!)
  end
  
  it "should return a Syscmd::Command object" do
    subject.exec!(TESTER).should be_a(Syscmd::Command)
  end
  
  it "should return an executed Syscmd::Command object" do
    cmd = subject.exec!(TESTER)
    cmd.executed?.should == true
  end
  
end
