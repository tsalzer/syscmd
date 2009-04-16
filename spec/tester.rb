#!/usr/bin/env ruby
# == Synopsis
#
# tester: test script for syscmd
#
# == Usage
#
# tester [OPTION]
#
# OPTIONS:
#   --help, -h                display this page
#   --stdout, -s  MSG         echo MSG to stdout
#   --stdoutrepeat, -S COUNT  print the stdout message COUNT times
#                             (DEFAULT: 1)
#   --stderr, -e MSG          echo MSG to stderr
#   --stderrrepeat, -E COUNT  print the stderr message COUNT times
#                             (DEFAULT: 1)
#   --exitcode, -x CODE       return exit code CODE
#   --debug

require "getoptlong"
require "rdoc/usage"

opts = GetoptLong.new(
  [ '--help',         '-h', GetoptLong::NO_ARGUMENT ],
  [ '--stdout',       '-s', GetoptLong::REQUIRED_ARGUMENT ],
  [ '--stdoutcount',  '-S', GetoptLong::REQUIRED_ARGUMENT ],
  [ '--stderr',       '-e', GetoptLong::REQUIRED_ARGUMENT ],
  [ '--stderrcount',  '-E', GetoptLong::REQUIRED_ARGUMENT ],
  [ '--exitcode',     '-x', GetoptLong::REQUIRED_ARGUMENT ],
  [ '--debug',              GetoptLong::OPTIONAL_ARGUMENT ]
)

options = {}
exitcode = 0

msg_stdout = nil
count_stdout = 1

msg_stderr = nil
count_stderr = 1

opts.each do |opt, arg|
  case opt
    when '--help'
      RDoc::usage
    when '--stdout'
      msg_stdout = arg
    when '--stdoutcount'
      count_stdout = arg.to_i
    when '--stderr'
      msg_stderr = arg
    when '--stderrcount'
      count_stderr = arg.to_i
    when '--exitcode'
      exitcode = arg.to_i
    when '--debug'
      # not yet implemented
  end
end

if msg_stdout
  count_stdout.times do
    $stdout.print "#{msg_stdout}\n"
  end
end

if msg_stderr
  count_stderr.times do
    $stderr.print "#{msg_stderr}\n"
  end
end

exit exitcode
