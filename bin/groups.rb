# /home/katcv/rubian/3_1_0/bin/groups.rb

def groups(username = nil)
  if username
    system("groups #{username}")
  else
    system("groups")
  end
end
