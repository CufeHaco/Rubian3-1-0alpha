# /home/katcv/rubian/3_1_0/bin/iostat.rb

def iostat(interval = nil)
  if interval
    system("iostat #{interval}")
  else
    system("iostat")
  end
end
