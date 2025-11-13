# /home/katcv/rubian/3_1_0/bin/passwd.rb

def passwd(username = nil)
  if username
    system("sudo passwd #{username}")
  else
    system("passwd")
  end
end
