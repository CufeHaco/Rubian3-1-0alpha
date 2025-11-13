# /home/katcv/rubian/3_1_0/bin/grep.rb

def grep(pattern, *files)
  if pattern.nil? || pattern.empty?
    puts "Usage: grep 'pattern' file1 [file2 ...]"
    return
  end

  # If no files specified, search all user files
  if files.empty?
    files = $user_files.select { |f| File.file?(f) }
    puts "Searching #{files.length} files..."
  end

  matches = []

  files.each do |string|
    # Resolve file path using arrays
    file_path = if File.exist?(string)
                  string
                else
                  $rubian_files.find { |f| f.end_with?(string) } ||
                  $user_files.find { |f| f.end_with?(string) }
                end

    next unless file_path && File.file?(file_path)

    begin
      File.readlines(file_path).each_with_index do |line, index|
        if line.match(/#{pattern}/i)
          matches << { file: file_path, line_num: index + 1, content: line.chomp }
        end
      end
    rescue => e
      puts "Error reading #{string}: #{e.message}"
    end
  end

  if matches.any?
    puts "\nFound #{matches.length} matches:"
    matches.each do |m|
      filename = File.basename(m[:file])
      puts "#{filename}:#{m[:line_num]}: #{m[:content]}"
    end
  else
    puts "No matches found for: #{pattern}"
  end

  matches
end
