# /home/katcv/rubian/3_1_0/bin/tee.rb

def tee(filename, append = false)
  if filename.nil?
    puts "Usage: tee 'filename' [append: true/false]"
    return
  end
  
  flag = append ? '-a' : ''
  system("tee #{flag} #{filename}")
  
  refresh if defined?(refresh)
end
