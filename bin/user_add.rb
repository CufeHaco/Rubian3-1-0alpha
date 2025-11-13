# /home/katcv/rubian/3_1_0/bin/useradd.rb

def useradd(username, home_dir = nil)
  if username.nil?
    puts "Usage: useradd 'username' [home_dir]"
    return
  end
  
  if home_dir
    system("sudo useradd -m -d #{home_dir} #{username}")
  else
    system("sudo useradd -m #{username}")
  end
  
  puts "User created: #{username}"
end
