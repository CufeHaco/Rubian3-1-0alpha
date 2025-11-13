   def refresh
      puts "Refreshing file system arrays..."
      boot = Rubian3::Boot.new 
      boot.boot_glob
      puts "User directories: #{$user_dirs.length}"
      puts "User files: #{$user_files.length}"
      puts "Rubian directories: #{$rubian_dirs.length}"
      puts "Rubian files: #{$rubian_files.length}"
      puts "Local bin files: #{$local_bin_files.length}"
      puts "File system refreshed!"
    end
