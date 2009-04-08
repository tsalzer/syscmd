require 'open3'

# Module.
module Syscmd
  class Command
    # execution state
    attr_reader :executed
    
    attr_reader :cmd
    attr_reader :args
    attr_reader :cmdline
    
    attr_reader :stdout
    attr_reader :stderr
    attr_reader :exitcode
    
    # execute a system command.
    #  cmd: the command to execute
    #  args: command line arguments
    def initialize(cmd, *args)
      @cmd = cmd
      @args = *args
      @executed = false
    end
    
    def exec!
      stdout = Array.new
      stderr = Array.new
      Open3.popen3(self.cmdline) do |stdin, stdout, stderr|
        stdout = stdout.read
        stderr = stderr.read
      end
      @stdout = stdout
      @stderr = stderr
      
      @executed = true
      self
    end
    
    def cmdline
      if @cmdline.nil?
        cmdline = "#{@cmd}"
        if @args
          @args.each do |arg|
            if arg.index(" ")
              cmdline << " \"#{arg}\""
            else
              cmdline << " #{arg}"
            end
          end
        end
        @cmdline = cmdline
      end
      @cmdline
    end
    
    def executed?
      return @exitcode.nil? ? false : true
    end
  end
  
  # execute a system command.
  #  cmd: the command to execute
  #  args: command line arguments
  #  returns: executed Syscmd::Command object
  def self.exec!(cmd, *args)
    cmd = Command.new(cmd, args)
    cmd.exec!
  end
end
