# /home/katcv/rubian/3_1_0/bin/userdel.rb

def userdel(username, remove_home = false)
  if username.nil?
    puts "Usage: userdel 'username' [remove_home: true/false]"
    return
  end
  
  if remove_home
    system("sudo userdel -r #{username}")
  else
    system("sudo userdel #{username}")
  end
  
  puts "User deleted: #{username}"
end
