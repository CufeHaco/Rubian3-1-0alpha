# /home/katcv/rubian/3_1_0/bin/netstat.rb

def netstat(options = '-tuln')
  system("netstat #{options}")
end
