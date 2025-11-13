# /home/katcv/rubian/3_1_0/bin/uname.rb

def uname(all = false)
  if all
    system("uname -a")
  else
    system("uname")
  end
end
