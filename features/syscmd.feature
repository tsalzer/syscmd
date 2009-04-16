Feature: execute a command
  In order to execute a command
  As a Syscmd::Command object
  I want a Syscmd::Command object instantiate and executed

Scenario: get no output
  Given no arguments
  When I execute ./spec/tester.rb
  Then I should get stdout ""
  And stderr ""
  And exitcode 0


Scenario: get "Hello World\n"
  Given argument -s "Hello World"
  When I execute ./spec/tester.rb
  Then I should get stdout "Hello World\n"
  And stderr ""
  And exitcode 0

Scenario: get "Bye Bye World\n" as stderr
  Given argument -e "Bye Bye World"
  When I execute ./spec/tester.rb
  Then I should get stdout ""
  And stderr "Bye Bye World\n"
  And exitcode 0

Scenario: get "Hello World\n" and exit code 1
  Given argument -s "Hello World"
  And argument -x 1
  When I execute ./spec/tester.rb
  Then I should get stdout "Hello World\n"
  And stderr ""
  And exitcode 1

Scenario: get "Hello World" as stdout and "Bye Bye\n" as stderr
  Given argument -s "Hello World"
  And argument -e "Bye Bye"
  When I execute ./spec/tester.rb
  Then I should get stdout "Hello World\n"
  And stderr "Bye Bye\n"
  And exitcode 0
