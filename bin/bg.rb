# /home/katcv/rubian/3_1_0/bin/bg.rb

def bg(command)
  if command.nil?
    puts "Usage: bg 'command'"
    return
  end
  
  thread = Thread.new do
    system(command)
  end
  
  $rubian_jobs ||= []
  $rubian_jobs << { command: command, thread: thread, pid: thread.object_id }
  
  puts "Job started in background: [#{$rubian_jobs.length - 1}]"
end
