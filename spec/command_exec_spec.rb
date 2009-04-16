require File.join(File.dirname(__FILE__), 'spec_helper')

describe Syscmd::Command, ".exec! for -s 'Hello World'" do
  subject { Syscmd::Command.new(TESTER, '-s', 'Hello World').exec! }
  
  it "should have stdout 'Hello World\\n'" do
    subject.stdout.should == "Hello World\n"
  end
  it "should have stdout_lines ['Hello World']" do
    subject.stdout_lines.should == ["Hello World"]
  end
  
  
  it "should have stderr \"\"" do
    subject.stderr.should == ""
  end
  
  it "should have exitcode 0" do
    subject.exitcode.should == 0
  end
end

describe Syscmd::Command, ".exec! for multiline output" do
  subject { Syscmd::Command.new(TESTER, 
    '-s', 'Hello World', '-S', 2,
    '-e', 'Bye Bye World', '-E', 2).exec! }
  
  it "should have stdout 'Hello World\\nHello World\\n'" do
    subject.stdout.should == "Hello World\nHello World\n"
  end
  it "should have two strings in stdout_lines" do
    subject.stdout_lines.should == ["Hello World", "Hello World"]
  end
  
  it "should have stderr 'Bye Bye World\\nBye Bye World\\n'" do
    subject.stderr.should == "Bye Bye World\nBye Bye World\n"
  end
  it "should have two strings in stdout_lines" do
    subject.stderr_lines.should == ["Bye Bye World", "Bye Bye World"]
  end
end

describe Syscmd::Command, ".exec! for positive exit codes" do
  [1, 2, 254, 255].each do |st|
    it "should return exit code #{st} for -x #{st}" do
      cmd = Syscmd::Command.new(TESTER, '-x', st)
      cmd.cmdline.should == "#{TESTER} -x #{st}"
      cmd.exec!
      cmd.exitcode.should == st
    end
  end
end

describe Syscmd::Command, ".exec! for hugh positive exit codes" do
  [256, 257, 512, 4000].each do |st|
    it "should return exit code #{st % 256} for -x #{st}" do
      cmd = Syscmd::Command.new(TESTER, '-x', st)
      cmd.cmdline.should == "#{TESTER} -x #{st}"
      cmd.exec!
      cmd.exitcode.should == st % 256
    end
  end
end

describe Syscmd::Command, ".exec! for negative exit codes" do
  [-1, -2, -255, -256].each do |st|
    it "should return exit code #{st % 256} for -x #{st}" do
      cmd = Syscmd::Command.new(TESTER, '-x', st)
      cmd.cmdline.should == "#{TESTER} -x #{st}"
      cmd.exec!
      cmd.exitcode.should == st % 256
    end
  end
end

describe Syscmd::Command, ".exec! called twice" do
  subject { Syscmd::Command.new(TESTER) }
  it "should fail with AlreadyExecutedError" do
    subject.exec!
    lambda { subject.exec! }.should raise_error(Syscmd::AlreadyExecutedError)
  end
end
