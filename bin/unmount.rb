# /home/katcv/rubian/3_1_0/bin/umount.rb

def umount(mountpoint)
  if mountpoint.nil?
    puts "Usage: umount 'mountpoint'"
    return
  end
  
  system("sudo umount #{mountpoint}")
end
