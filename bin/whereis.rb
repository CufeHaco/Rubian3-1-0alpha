# /home/katcv/rubian/3_1_0/bin/whereis.rb

def whereis(command)
  if command.nil?
    puts "Usage: whereis 'command'"
    return
  end
  
  system("whereis #{command}")
end
