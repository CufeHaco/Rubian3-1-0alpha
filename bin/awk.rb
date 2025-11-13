# /home/katcv/rubian/3_1_0/bin/awk.rb

def awk(pattern, *files)
  if pattern.nil?
    puts "Usage: awk 'pattern' [files...]"
    puts "Example: awk '{print $1}' file.txt"
    return
  end
  
  if files.empty?
    system("awk '#{pattern}'")
  else
    files.each do |string|
      file_path = if File.exist?(string)
                    string
                  else
                    $rubian_files.find { |f| f.end_with?(string) } ||
                    $user_files.find { |f| f.end_with?(string) }
                  end
      
      if file_path && File.file?(file_path)
        system("awk '#{pattern}' #{file_path}")
      else
        puts "#{string} not found!"
      end
    end
  end
end
