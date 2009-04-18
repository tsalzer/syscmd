Feature: split multiline output into an array of lines.
  In order simpify processing of multiple output lines
  I want a Syscmd::Command object to split the output of the command

Scenario: split a two-line output into two single strings
  Given argument -s "Hello World"
  And argument -S 2
  When I execute ./spec/tester.rb
  Then I should get stdout_lines ["Hello World", "Hello World"]
  And stderr_lines []
  And exitcode 0

Scenario: split a two-line output into two single strings
  Given argument -s "Hello World"
  And argument -S 2
  And argument -e "Bye Bye"
  And argument -E 2
  And argument -x 1
  When I execute ./spec/tester.rb
  Then I should get stdout_lines ["Hello World", "Hello World"]
  And stderr_lines ["Bye Bye", "Bye Bye"]
  And exitcode 1
