# /home/katcv/rubian/3_1_0/bin/history.rb

def history(lines = 50)
  if defined?(Readline::HISTORY)
    count = [lines, Readline::HISTORY.length].min
    start_index = [Readline::HISTORY.length - count, 0].max
    
    puts "\n=== COMMAND HISTORY (last #{count}) ==="
    (start_index...Readline::HISTORY.length).each do |i|
      puts "#{i + 1}: #{Readline::HISTORY[i]}"
    end
  else
    puts "Command history not available"
  end
end
