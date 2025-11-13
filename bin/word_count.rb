# /home/katcv/rubian/3_1_0/bin/wc.rb

def wc(*files)
  if files.empty?
    puts "Usage: wc 'file1' ['file2' ...]"
    return
  end

  total_lines = 0
  total_words = 0
  total_chars = 0

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

    if Dir.exist?(file_path)
      puts "#{string} is a Directory."
      next
    end

    begin
      content = File.read(file_path)
      lines = content.lines.count
      words = content.split.count
      chars = content.length

      total_lines += lines
      total_words += words
      total_chars += chars

      puts "#{lines.to_s.rjust(8)} #{words.to_s.rjust(8)} #{chars.to_s.rjust(8)} #{string}"
    rescue => e
      puts "Error: #{e.message}"
    end
  end

  if files.length > 1
    puts "#{total_lines.to_s.rjust(8)} #{total_words.to_s.rjust(8)} #{total_chars.to_s.rjust(8)} total"
  end
end
