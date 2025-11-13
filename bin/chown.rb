# /home/katcv/rubian/3_1_0/bin/chown.rb

def chown(owner, *files)
  if owner.nil? || files.empty?
    puts "Usage: chown 'user:group' file1 [file2 ...]"
    puts "Example: chown 'katcv:katcv' file.txt"
    return
  end
  
  files.each do |string|
    file_path = if File.exist?(string)
                  string
                else
                  $rubian_files.find { |f| f.end_with?(string) } ||
                  $user_files.find { |f| f.end_with?(string) }
                end
    
    if file_path && File.exist?(file_path)
      system("chown #{owner} #{file_path}")
      puts "Changed: #{File.basename(file_path)} to #{owner}"
    else
      puts "#{string} not found!"
    end
  end
end
