# /home/katcv/rubian/3_1_0/bin/fdisk.rb

def fdisk(device = nil)
  if device
    system("sudo fdisk #{device}")
  else
    system("sudo fdisk -l")
  end
end
