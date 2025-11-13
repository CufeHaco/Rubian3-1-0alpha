# /home/katcv/rubian/3_1_0/bin/df.rb

def df(human_readable = true)
  if human_readable
    system("df -h")
  else
    system("df")
  end
end
