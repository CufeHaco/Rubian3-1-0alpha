# /home/katcv/rubian/3_1_0/bin/file.rb

def file(*files)
  if files.empty?
    puts "Usage: file 'file1' [file2 ...]"
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
      system("file #{file_path}")
    else
      puts "#{string} not found!"
    end
  end
end
