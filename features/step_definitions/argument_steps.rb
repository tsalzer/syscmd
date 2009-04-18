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
    @args << arg2.to_i
  else
    @args = [arg1, arg2.to_i]
  end
end
