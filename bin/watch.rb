# /home/katcv/rubian/3_1_0/bin/watch.rb

def watch(interval = 2, command)
  if command.nil?
    puts "Usage: watch [interval] 'command'"
    puts "Example: watch 5 'ls -la'"
    return
  end
  
  system("watch -n #{interval} '#{command}'")
end
