# /home/katcv/rubian/3_1_0/bin/which.rb

def which(command)
  if command.nil?
    puts "Usage: which 'command'"
    return
  end
  
  system("which #{command}")
end
