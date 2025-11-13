# /home/katcv/rubian/3_1_0/bin/mount.rb

def mount(device = nil, mountpoint = nil)
  if device.nil? && mountpoint.nil?
    system("mount")
  elsif device && mountpoint
    system("sudo mount #{device} #{mountpoint}")
  else
    puts "Usage: mount [device] [mountpoint]"
    puts "Example: mount '/dev/sdb1' '/mnt/usb'"
  end
end
