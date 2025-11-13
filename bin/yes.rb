# /home/katcv/rubian/3_1_0/bin/yes.rb

def yes(string = 'y')
  puts "Press Ctrl+C to stop"
  system("yes #{string}")
end 
