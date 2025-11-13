def cd(string)
  # Check if it's an exact path that exists
  if Dir.exist?(string)
    Dir.chdir(string)
    return
  end
  
  # Search in rubian directories
  dir_path = $rubian_dirs.find { |d| d.end_with?("#{string}/") || d == string }
  
  # If not found in rubian, search user directories
  dir_path ||= $user_dirs.find { |d| d.end_with?("#{string}/") || d == string }
  
  if dir_path && Dir.exist?(dir_path)
    Dir.chdir(dir_path)
  else
    puts "#{string} :not found!"
  end
end
