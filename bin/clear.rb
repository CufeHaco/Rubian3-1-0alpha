# /rubian/bin/clear.rb

def clear(show_status: true)
  print "\e[2J\e[H"
  
  if show_status
    puts $version
    puts $ruby_version
    puts Time.now
    puts "PWD: #{Dir.pwd}"
    
    if defined?($rubian_files)
      loaded_count = $LOADED_FEATURES.select { |f| f.include?('rubian') }.length
      puts "\nLoaded: #{loaded_count} rubian files"
      puts "Arrays: #{$rubian_files.length} files, #{$rubian_dirs.length} dirs"
    end
    
    puts "\n" + "="*60
  else
    puts $version
    puts Time.now
  end
end

# Alias for minimal clear
def cls
  clear(show_status: false)
end
