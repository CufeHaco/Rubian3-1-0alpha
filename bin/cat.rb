# /rubian/3_1_0/bin/cat.rb

def cat(*files)
  # Handle no arguments
  if files.empty?
    puts "Usage: cat 'file1' ['file2' ...]"
    return
  end
  
  # Process each file
  files.each do |string|
    # If it's already a full path from array, use it
    file_path = if File.exist?(string)
                  string
                else
                  # Search arrays for matching filename
                  $rubian_files.find { |f| f.end_with?(string) } ||
                  $user_files.find { |f| f.end_with?(string) }
                end

    if file_path.nil?
      puts "#{string} not found!"
    elsif Dir.exist?(file_path)
      puts "#{string} is a Directory."
    elsif File.file?(file_path)
      # Show filename header if multiple files
      puts "\n==> #{string} <==" if files.length > 1
      puts File.readlines(file_path)
    else
      puts "#{string} not found!"
    end
  end
end
