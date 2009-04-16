require 'syscmd/popen'

# Module.
module Syscmd
  # Error raise if a command object is executed twice.
  class AlreadyExecutedError < RuntimeError ; end
  
  # A command to execute.
  # You usually just use Syscmd::exec! to create and execute the command.
  # A command object can be executed only once.
  class Command
    # +true+ if the command was already executed, otherwise +false+.
    attr_reader :executed
    
    # the command to execute.
    attr_reader :cmd
    # array of arguments.
    attr_reader :args
    # the constructed command line.
    attr_reader :cmdline
    
    # standard output of the executed command.
    attr_reader :stdout
    # standard error of the executed command.
    attr_reader :stderr
    # exit code of the executed command.
    # Note that the exit code is just a Byte value ranged 0..255 on
    # Unix platforms, so don't expect any negative values or values greated
    # than 255 here.
    attr_reader :exitcode
    # exit status of the executed command.
    attr_reader :process_status
    
    # execute a system command.
    #  cmd: the command to execute
    #  args: command line arguments
    def initialize(cmd, *args)
      @cmd = cmd
      @args = *args
      @process_status = nil
      @executed = false
    end
    
    # execute the command.
    # raises AlreadyExecutedError if the command is already executed.
    def exec!
      raise AlreadyExecutedError.new("already executed with status #{process_status}") if self.executed?
      @process_status, pread, perr = Syscmd::popen(self.cmdline)
      @stdout = pread.read
      @stderr = perr.read
      self
    end
    
    # get the stdout as lines.
    def stdout_lines
      if @stdout_lines.nil?
        stdout = self.stdout
        return nil unless stdout
        @stdout_lines = stdout.split(/\n/)
      end
      @stdout_lines
    end
    
    # get the stdout as lines.
    def stderr_lines
      if @stderr_lines.nil?
        stderr = self.stderr
        return nil unless stderr
        @stderr_lines = stderr.split(/\n/)
      end
      @stderr_lines
    end
    
    # the exitcode of the executed command.
    # returns nil 
    def exitcode
      @process_status ? @process_status.exitstatus : nil
    end
    
    # build the command line for this command.
    # Once the command line is created, it will be cached.
    def cmdline
      if @cmdline.nil?
        cmdline = "#{@cmd}"
        @args.each do |arg|
          cmdline << (arg.to_s.index(" ") ? " \"#{arg}\"" : " #{arg}")
        end if @args
        @cmdline = cmdline
      end
      @cmdline
    end
    
    # check if the command was executed.
    def executed
      @process_status.nil? ? false : true
    end
    alias executed? executed
  end
  
  # execute a system command.
  # cmd::     the command to execute
  # args::    command line arguments
  # returns:: executed Syscmd::Command object
  def exec!(cmd, *args)
    cmd = Command.new(cmd, args)
    cmd.exec!
  end
  module_function :'exec!'
end
