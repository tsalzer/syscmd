#!/usr/bin/env ruby
# == Synopsis
#
# tester: test script for syscmd
#
# == Usage
#
# tester [OPTION]
#
# COMMANDS:
#  list:
#    list all available project. No option required.
#  show:
#    show a project. You must provide a PROJECTNAME and a SCOPE. Valid SCOPEs
#    are: [env]ironment, [ver]sion
#  deploy:
#    deploys a given build to an environment. You must provide PROJECTNAME,
#    BUILD and ENVRIONMENT.
#
# OPTIONS:
#   --help, -h
#   --stdout, -s
#   --stderr, -e
#   --exitcode, -x
#   --debug

require "getoptlong"
require "rdoc/usage"

opts = GetoptLong.new(
  [ '--help',     '-h', GetoptLong::NO_ARGUMENT ],
  [ '--stdout',   '-s', GetoptLong::REQUIRED_ARGUMENT ],
  [ '--stderr',   '-e', GetoptLong::REQUIRED_ARGUMENT ],
  [ '--exitcode', '-x', GetoptLong::REQUIRED_ARGUMENT ],
  [ '--debug',          GetoptLong::OPTIONAL_ARGUMENT ]
)

options = {}
exitcode = 0

opts.each do |opt, arg|
  case opt
    when '--help'
      RDoc::usage
    when '--stdout'
      $stdout.print arg
    when '--stderr'
      $stderr.print arg
    when '--exitcode'
      exitcode = arg.to_i
    when '--debug'
      # not yet implemented
  end
end

exit exitcode
