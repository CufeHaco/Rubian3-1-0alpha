# /home/katcv/rubian/3_1_0/bin/xargs.rb

def xargs(command, *inputs)
  if command.nil?
    puts "Usage: xargs 'command' [inputs...]"
    puts "Example: xargs 'echo' 'file1' 'file2'"
    return
  end
  
  inputs.each do |input|
    system("echo #{input} | xargs #{command}")
  end
end
