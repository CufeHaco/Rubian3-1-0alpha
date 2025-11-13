# /home/katcv/rubian/3_1_0/bin/tar.rb

def tar(action, archive, *files)
  if action.nil? || archive.nil?
    puts "Usage: tar 'action' 'archive.tar.gz' [files...]"
    puts "Actions: create, extract, list"
    return
  end
  
  case action
  when 'create', 'c'
    if files.empty?
      puts "No files specified for archive"
      return
    end
    system("tar -czf #{archive} #{files.join(' ')}")
    puts "Created: #{archive}"
    refresh if defined?(refresh)
    
  when 'extract', 'x'
    system("tar -xzf #{archive}")
    puts "Extracted: #{archive}"
    refresh if defined?(refresh)
    
  when 'list', 'l'
    system("tar -tzf #{archive}")
    
  else
    puts "Unknown action: #{action}"
    puts "Use: create, extract, or list"
  end
end
