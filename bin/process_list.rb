# /home/katcv/rubian/3_1_0/bin/ps.rb

def ps(filter = nil)
  if filter
    system("ps aux | grep #{filter}")
  else
    system("ps aux")
  end
end
