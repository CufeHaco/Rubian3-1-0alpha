# /home/katcv/rubian/3_1_0/bin/zip.rb

def zip(archive, *files)
  if archive.nil? || files.empty?
    puts "Usage: zip 'archive.zip' file1 [file2 ...]"
    return
  end
  
  resolved_files = []
  
  files.each do |string|
    file_path = if File.exist?(string)
                  string
                else
                  $rubian_files.find { |f| f.end_with?(string) } ||
                  $user_files.find { |f| f.end_with?(string) }
                end
    
    if file_path
      resolved_files << file_path
    else
      puts "Warning: #{string} not found, skipping"
    end
  end
  
  if resolved_files.any?
    system("zip #{archive} #{resolved_files.join(' ')}")
    puts "Created: #{archive}"
    refresh if defined?(refresh)
  else
    puts "No files to archive"
  end
end
