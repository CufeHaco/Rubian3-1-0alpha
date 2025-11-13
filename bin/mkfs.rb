# /home/katcv/rubian/3_1_0/bin/mkfs.rb

def mkfs(type, device)
  if type.nil? || device.nil?
    puts "Usage: mkfs 'type' 'device'"
    puts "Example: mkfs 'ext4' '/dev/sdb1'"
    return
  end
  
  system("sudo mkfs.#{type} #{device}")
end
