# /home/katcv/rubian/3_1_0/bin/chmod.rb

def chmod(mode, *files)
  if mode.nil? || files.empty?
    puts "Usage: chmod 'mode' file1 [file2 ...]"
    puts "Example: chmod '755' script.rb"
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
      system("chmod #{mode} #{file_path}")
      puts "Changed: #{File.basename(file_path)} to #{mode}"
    else
      puts "#{string} not found!"
    end
  end
end
