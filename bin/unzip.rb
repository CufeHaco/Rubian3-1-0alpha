# /home/katcv/rubian/3_1_0/bin/unzip.rb

def unzip(archive, destination = nil)
  if archive.nil?
    puts "Usage: unzip 'archive.zip' [destination]"
    return
  end
  
  file_path = if File.exist?(archive)
                archive
              else
                $rubian_files.find { |f| f.end_with?(archive) } ||
                $user_files.find { |f| f.end_with?(archive) }
              end
  
  if file_path.nil?
    puts "#{archive} not found!"
    return
  end
  
  if destination
    system("unzip #{file_path} -d #{destination}")
  else
    system("unzip #{file_path}")
  end
  
  puts "Extracted: #{archive}"
  refresh if defined?(refresh)
end
