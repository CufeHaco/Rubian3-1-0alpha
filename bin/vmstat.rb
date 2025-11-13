# /home/katcv/rubian/3_1_0/bin/vmstat.rb

def vmstat(interval = nil)
  if interval
    system("vmstat #{interval}")
  else
    system("vmstat")
  end
end
