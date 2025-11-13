def dir_log
  puts "Rubian Directories:"
  $rubian_dirs.each_with_index { |d, i| puts "  [#{i}] #{d}" }
  puts "\nRubian Files:"
  $rubian_files.each_with_index { |f, i| puts "  [#{i}] #{f}" }
end
