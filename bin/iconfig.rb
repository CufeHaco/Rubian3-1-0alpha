# /home/katcv/rubian/3_1_0/bin/ifconfig.rb

def ifconfig(interface = nil)
  if interface
    system("ifconfig #{interface}")
  else
    system("ifconfig")
  end
end
