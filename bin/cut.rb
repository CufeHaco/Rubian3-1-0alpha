# /home/katcv/rubian/3_1_0/bin/cut.rb

def cut(field, delimiter = "\t", *files)
  if field.nil? || files.empty?
    puts "Usage: cut 'field' [delimiter] file1 [file2 ...]"
    puts "Example: cut '1' ',' data.csv"
    return
  end
  
  files.each do |string|
    file_path = if File.exist?(string)
                  string
                else
                  $rubian_files.find { |f| f.end_with?(string) } ||
                  $user_files.find { |f| f.end_with?(string) }
                end
    
    if file_path && File.file?(file_path)
      system("cut -d'#{delimiter}' -f#{field} #{file_path}")
    else
      puts "#{string} not found!"
    end
  end
end
