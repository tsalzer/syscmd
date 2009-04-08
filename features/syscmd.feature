Feature: execute a command
  In order to execute a command
  As a Syscmd::Command object
  I want instantiate a Syscmd::Command object execute it

Scenario: get no output
  Given no arguments
  When I execute ./spec/tester.rb
  Then I should get stdout ""
  And stderr ""
  And exitcode 0


Scenario: get "Hello World"
  Given argument -s "Hello World"
  When I execute ./spec/tester.rb
  Then I should get stdout "Hello World"
  And stderr ""
  And exitcode 0

Scenario: get "Bye Bye World" as stderr
  Given argument -e "Bye Bye World"
  When I execute ./spec/tester.rb
  Then I should get stdout ""
  And stderr "Bye Bye World"
  And exitcode 0

Scenario: get "Hello World" and exit code 1
  Given argument -s "Hello World"
  And argument -x 1
  When I execute ./spec/tester.rb
  Then I should get stdout "Hello World"
  And stderr ""
  And exitcode 1

Scenario: get "Hello World" as stdout and "Bye Bye" as stderr
  Given argument -s "Hello World"
  And argument -e "Bye Bye"
  When I execute ./spec/tester.rb
  Then I should get stdout "Hello World"
  And stderr "Bye Bye"
  And exitcode 0
