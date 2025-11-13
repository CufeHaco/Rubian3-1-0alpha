# /home/katcv/rubian/3_1_0/bin/time_cmd.rb

def time_cmd(command)
  if command.nil?
    puts "Usage: time_cmd 'command'"
    return
  end
  
  start_time = Time.now
  system(command)
  end_time = Time.now
  
  elapsed = end_time - start_time
  puts "\nElapsed time: #{elapsed.round(3)} seconds"
end
