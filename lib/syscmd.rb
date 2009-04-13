require 'syscmd/popen'

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
    def exec!
#      @process_status, pwrite, pread, perr = Syscmd::popen(self.cmdline)
      @process_status, pread, perr = Syscmd::popen(self.cmdline)
      @stdout = pread.read
      @stderr = perr.read
      self
    end
    
    def exitcode
      if @process_status
        #@process_status
        @process_status.exitstatus
      else
        nil
      end
    end
    
    # build the command line for this command.
    # Once the command line is created, it will be cached.
    def cmdline
      if @cmdline.nil?
        cmdline = "#{@cmd}"
        if @args
          @args.each do |arg|
            if arg.to_s.index(" ")
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
  def self.exec!(cmd, *args)
    cmd = Command.new(cmd, args)
    cmd.exec!
  end
end
