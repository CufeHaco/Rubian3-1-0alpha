# /home/katcv/rubian/3_1_0/bin/ssh.rb

def ssh(host, user = nil, port = 22)
  if host.nil?
    puts "Usage: ssh 'host' [user] [port]"
    puts "Example: ssh 'example.com' 'username' 22"
    return
  end
  
  if user
    system("ssh -p #{port} #{user}@#{host}")
  else
    system("ssh -p #{port} #{host}")
  end
end
