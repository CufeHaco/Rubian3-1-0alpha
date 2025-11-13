# /rubian/3_1_0/bin/system_status.rb

def system_status
  puts "\n" + "="*70
  puts " RUBIAN SYSTEM STATUS"
  puts "="*70
  
  puts "\n--- VERSION INFO ---"
  puts "  Rubian:        #{$version}"
  puts "  Ruby:          #{$ruby_version}"
  puts "  Working Dir:   #{Dir.pwd.gsub("/home/#{ENV['USER']}/", "~/")}"
  puts "  Time:          #{Time.now}"
  
  puts "\n--- FILE SYSTEM ARRAYS ---"
  puts "  Rubian Files:      #{$rubian_files.length.to_s.rjust(6)}"
  puts "  Rubian Dirs:       #{$rubian_dirs.length.to_s.rjust(6)}"
  puts "  Local Bin Files:   #{$local_bin_files.length.to_s.rjust(6)}"
  puts "  User Files:        #{$user_files.length.to_s.rjust(6)}"
  puts "  User Dirs:         #{$user_dirs.length.to_s.rjust(6)}"
  
  puts "\n--- LOADED MODULES ---"
  loaded_rubian = $LOADED_FEATURES.select { |f| f.include?('rubian') }.length
  loaded_total = $LOADED_FEATURES.length
  puts "  Rubian Modules:    #{loaded_rubian.to_s.rjust(6)}"
  puts "  Total Loaded:      #{loaded_total.to_s.rjust(6)}"
  
  puts "\n--- PROCESS INFO ---"
  puts "  Process ID:        #{Process.pid.to_s.rjust(6)}"
  puts "  Process Title:     #{$0}"
  
  puts "\n--- AVAILABLE COMMANDS ---"
  puts "  rubian_files       - View Rubian files by status"
  puts "  user_files         - View user files by location"
  puts "  user_dirs          - View user directories"
  puts "  local_bin_files    - View current version bin files"
  puts "  ls, cat, cd        - File operations"
  puts "  touch, cp, mv      - File manipulation"
  puts "  nano, qn, qw       - Text editors"
  
  puts "="*70 + "\n"
end

# Alias
alias status system_status
