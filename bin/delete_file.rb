def delfile(string)
  # Search arrays for file
  file_path = if File.exist?(string)
                string
              else
                $rubian_files.find { |f| f.end_with?(string) } ||
                $user_files.find { |f| f.end_with?(string) }
              end
  
  if file_path && File.exist?(file_path)
    File.delete(file_path)
    puts "File: #{file_path} Deleted!"
    refresh  # Update arrays after deletion
  else
    puts "#{string} not found!"
  end
end
