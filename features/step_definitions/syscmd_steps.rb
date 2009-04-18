When /^I execute (.+)$/ do |cmd|
  @cmd = Syscmd::Command.new(cmd, @args)
  @cmd.exec!
end

Then /^(I should get )?(stdout|stderr) "(.*)"$/ do |ignore, channel, expected|
  expected.sub!(/\\n/, "\n")
  @cmd.send(channel).should == expected
end

Then /^(I should get )?(stdout|stderr) nil$/ do |ignore,channel|
  @cmd.send(channel).should == nil
end

Then /^(I should get )?(stdout|stderr)_lines (\[.*\])$/ do |ignore, channel, expected_lines|
  splitted = expected_lines[1,expected_lines.length-2].split(/[,]/)
  lines = splitted.collect do |s|
    /"(.*)"/.match(s)[1]
  end
  @cmd.send("#{channel}_lines").should == lines
end

Then /^exitcode (\d+)$/ do |exitcode|
#  pending "exit code not yet implemented" do
    @cmd.exitcode.should == exitcode.to_i
#  end
end
