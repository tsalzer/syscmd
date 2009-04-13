Given /^no arguments$/ do
  @args = nil
end

Given /argument (\-[a-zA-Z]) "([^\"]*)"$/ do |arg1, arg2|
  if @args
    @args << arg1
    @args << arg2
  else
    @args = [arg1, arg2]
  end
end

Given /argument (\-[a-zA-Z]) (\d+)$/ do |arg1, arg2|
  if @args
    @args << arg1
    @args << arg2
  else
    @args = [arg1, arg2]
  end
end


When /^I execute (.+)$/ do |cmd|
  @cmd = Syscmd::Command.new(cmd, @args)
  @cmd.exec!
end

Then /^I should get stdout "(.*)"$/ do |stdout|
  @cmd.stdout.should == stdout
end

Then /^I should get stdout nil$/ do
  @cmd.stdout.should == nil
end


Then /^stdout "(.*)"$/ do |stdout|
  @cmd.stdout.should == stdout
end

Then /^stdout nil$/ do
  @cmd.stdout.should == nil
end

Then /^stderr "(.*)"$/ do |stderr|
  @cmd.stderr.should == stderr
end

Then /^stderr nil$/ do
  @cmd.stderr.should == nil
end

Then /^exitcode (\d+)$/ do |exitcode|
#  pending "exit code not yet implemented" do
    @cmd.exitcode.should == exitcode.to_i
#  end
end
