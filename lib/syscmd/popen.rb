module Syscmd
  # Taken from the original Ruby 1.8 implementation of Open3::open3 and slightly
  # tweaked to return an exit status.
  # This function is meant as in internal method of the Syscmd module; do not use
  # it on it's own, as the interface may change anytime.
  #
  # cmd::       the command to execute
  # returns::   status, stdout, stderr
  #
  # orignal author::        Yukihiro Matsumoto
  # orignal socumentation:: Konrad Meyer
  def popen(*cmd)
    pw = IO::pipe   # pipe[0] for read, pipe[1] for write
    pr = IO::pipe
    pe = IO::pipe
    status = 0 # status of the inner fork

    pid = fork do
      # child
      gcpid = fork do
      	# grandchild
      	pw[1].close
      	STDIN.reopen(pw[0])
      	pw[0].close

      	pr[0].close
      	STDOUT.reopen(pr[1])
      	pr[1].close

      	pe[0].close
      	STDERR.reopen(pe[1])
      	pe[1].close

      	exec(*cmd)
      end
      gcpid, gcstatus = Process.wait2(gcpid)
      exit!(gcstatus.exitstatus)
    end

    pw[0].close
    pr[1].close
    pe[1].close
    pid, status = Process.wait2(pid)
    
    #pi = [status.exitstatus, pw[1], pr[0], pe[0]]
    pi = [status, pr[0], pe[0]]
    pw[1].sync = true
    if defined? yield
      begin
	      return yield(*pi)
      ensure
	      pi.each{|p| p.close unless p.closed?}
      end
    end
    pi
  end
  module_function :popen
end
