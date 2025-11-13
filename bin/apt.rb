# /home/katcv/rubian/3_1_0/bin/apt.rb

def apt(action, *packages)
  if action.nil?
    puts "Usage: apt 'action' [packages...]"
    puts "Actions: install, remove, update, upgrade, search"
    return
  end
  
  case action
  when 'install'
    system("sudo apt install -y #{packages.join(' ')}")
  when 'remove'
    system("sudo apt remove -y #{packages.join(' ')}")
  when 'update'
    system("sudo apt update")
  when 'upgrade'
    system("sudo apt upgrade -y")
  when 'search'
    system("apt search #{packages.first}")
  else
    system("apt #{action} #{packages.join(' ')}")
  end
end
