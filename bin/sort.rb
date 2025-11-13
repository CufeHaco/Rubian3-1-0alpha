# /home/katcv/rubian/3_1_0/bin/sort.rb

def sort(string, reverse = false)
  file_path = if File.exist?(string)
                string
              else
                $rubian_files.find { |f| f.end_with?(string) } ||
                $user_files.find { |f| f.end_with?(string) }
              end
  
  if file_path.nil?
    puts "#{string} not found!"
    return
  end
  
  begin
    lines = File.readlines(file_path)
    sorted = reverse ? lines.sort.reverse : lines.sort
    sorted.each { |line| puts line }
  rescue => e
    puts "Error: #{e.message}"
  end
end
