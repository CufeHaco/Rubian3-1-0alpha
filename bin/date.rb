# /home/katcv/rubian/3_1_0/bin/date.rb

def date(format = nil)
  if format
    system("date '+#{format}'")
  else
    puts Time.now
  end
end
