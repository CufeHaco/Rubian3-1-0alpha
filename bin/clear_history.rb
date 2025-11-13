# /home/katcv/rubian/3_1_0/bin/clear_history.rb

def clear_history
  if defined?(Readline::HISTORY)
    Readline::HISTORY.clear
    puts "Command history cleared"
  else
    puts "Command history not available"
  end
end
