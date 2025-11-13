# /home/katcv/rubian/3_1_0/bin/ping.rb

def ping(host, count = 4)
  if host.nil? || host.empty?
    puts "Usage: ping 'host' [count]"
    return
  end

  puts "PING #{host} (#{count} packets)..."
  system("ping -c #{count} #{host}")
end
