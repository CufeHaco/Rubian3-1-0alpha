# /home/katcv/rubian/3_1_0/bin/journalctl.rb

def journalctl(options = '-xe')
  system("journalctl #{options}")
end
