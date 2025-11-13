# /home/katcv/rubian/3_1_0/bin/tail_log.rb

def tail_log(logfile = '/var/log/syslog', lines = 50)
  if File.exist?(logfile)
    system("tail -n #{lines} -f #{logfile}")
  else
    puts "Log file not found: #{logfile}"
    puts "Common logs: /var/log/syslog, /var/log/auth.log, /var/log/kern.log"
  end
end
