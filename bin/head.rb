# /home/katcv/rubian/3_1_0/bin/head.rb

def head(string, lines = 10)
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

  if Dir.exist?(file_path)
    puts "#{string} is a Directory."
    return
  end

  begin
    content = File.readlines(file_path)
    puts "==> #{string} (first #{lines} lines) <=="
    content.first(lines).each { |line| puts line }
  rescue => e
    puts "Error: #{e.message}"
  end
end
