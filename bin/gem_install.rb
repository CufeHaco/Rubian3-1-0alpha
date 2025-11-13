# /home/katcv/rubian/3_1_0/bin/gem_cmd.rb

def gem_install(*packages)
  if packages.empty?
    puts "Usage: gem_install 'package1' [package2 ...]"
    return
  end
  
  packages.each do |pkg|
    system("gem install #{pkg}")
  end
end

def gem_list(pattern = nil)
  if pattern
    system("gem list #{pattern}")
  else
    system("gem list")
  end
end

def gem_uninstall(*packages)
  if packages.empty?
    puts "Usage: gem_uninstall 'package1' [package2 ...]"
    return
  end
  
  packages.each do |pkg|
    system("gem uninstall #{pkg}")
  end
end
