# /home/katcv/rubian/3_1_0/bin/dmesg.rb

def dmesg(filter = nil)
  if filter
    system("dmesg | grep -i #{filter}")
  else
    system("dmesg")
  end
end
