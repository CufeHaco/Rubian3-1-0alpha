# /home/katcv/rubian/3_1_0/bin/sleep_cmd.rb

def sleep_cmd(seconds)
  if seconds.nil?
    puts "Usage: sleep_cmd seconds"
    return
  end
  
  sleep(seconds.to_f)
  puts "Slept for #{seconds} seconds"
end
