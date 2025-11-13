# Updated for 3_1_0/bin/delete_dir.rb
def deldir(string)
  # Search arrays for directory
  dir_path = if Dir.exist?(string)
               string
             else
               $rubian_dirs.find { |d| d.end_with?("#{string}/") } ||
               $user_dirs.find { |d| d.end_with?("#{string}/") }
             end
  
  if dir_path && Dir.exist?(dir_path)
    Dir.delete(dir_path)
    puts "Dir: #{dir_path} Deleted!"
    refresh  # Update arrays after deletion
  else
    puts "#{string} not found!"
  end
end
