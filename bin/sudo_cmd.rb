# /home/katcv/rubian/3_1_0/bin/sudo_cmd.rb

def sudo_cmd(*command)
  if command.empty?
    puts "Usage: sudo_cmd 'command' [args...]"
    return
  end
  
  system("sudo #{command.join(' ')}")
end
