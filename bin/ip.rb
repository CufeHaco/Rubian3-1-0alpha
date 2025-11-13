# /home/katcv/rubian/3_1_0/bin/ip.rb

def ip(command = 'addr')
  system("ip #{command}")
end
