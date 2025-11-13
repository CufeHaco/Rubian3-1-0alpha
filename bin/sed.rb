# /home/katcv/rubian/3_1_0/bin/sed.rb

def sed(pattern, replacement, *files)
  if pattern.nil? || replacement.nil? || files.empty?
    puts "Usage: sed 'pattern' 'replacement' file1 [file2 ...]"
    puts "Example: sed 'old' 'new' file.txt"
    return
  end
  
  files.each do |string|
    file_path = if File.exist?(string)
                  string
                else
                  $rubian_files.find { |f| f.end_with?(string) } ||
                  $user_files.find { |f| f.end_with?(string) }
                end
    
    if file_path.nil?
      puts "#{string} not found!"
      next
    end
    
    begin
      content = File.read(file_path)
      modified = content.gsub(/#{pattern}/, replacement)
      puts "==> #{string} <==" if files.length > 1
      puts modified
    rescue => e
      puts "Error: #{e.message}"
    end
  end
end
