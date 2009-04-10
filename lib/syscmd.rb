#require 'open3'
require 'open4'

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
#      sout = Array.new
#      serr = Array.new
#      Open4::open4(self.cmdline) do |stdin, stdout, stderr, status|
#        sout = stdout #.read
#        serr = stderr #.read
#        @process_status = status
#      end
#      @stdout = sout
#      @stderr = serr
      
      cid, pwrite, pread, perr = Open4::popen4(self.cmdline)
#      @process_status = $?
      @stdout = pread.read
      @stderr = perr.read
      @process_status = cid
      
      @executed = true
      self
    end
    
    def exitcode
      if @process_status
        #@process_status.exitstatus
        @process_status
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
      return @exitcode.nil? ? false : true
    end
    alias executed? executed
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
