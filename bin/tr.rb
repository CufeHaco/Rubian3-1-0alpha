# /home/katcv/rubian/3_1_0/bin/tr.rb

def tr(set1, set2, string)
  if set1.nil? || set2.nil? || string.nil?
    puts "Usage: tr 'set1' 'set2' 'file'"
    puts "Example: tr 'a-z' 'A-Z' file.txt"
    return
  end
  
  file_path = if File.exist?(string)
                string
              else
                $rubian_files.find { |f| f.end_with?(string) } ||
                $user_files.find { |f| f.end_with?(string) }
              end
  
  if file_path && File.file?(file_path)
    system("cat #{file_path} | tr '#{set1}' '#{set2}'")
  else
    puts "#{string} not found!"
  end
end
