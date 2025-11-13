# /rubian/3_1_0/bin/append.rb

def append(filename, text = nil)
  # Resolve file path (prefer pwd)
  file_path = if filename.include?('/')
                filename
              else
                File.join(Dir.pwd, filename)
              end
  
  # If no text provided, read from stdin until Ctrl+D
  unless text
    puts "Enter text (Ctrl+D when finished):"
    text = $stdin.read
  end
  
  begin
    File.open(file_path, 'a') do |f|
      f.puts(text)
    end
    puts "Appended to: #{file_path}"
  rescue Errno::ENOENT
    # File doesn't exist, create it
    puts "File doesn't exist, creating..."
    File.open(file_path, 'w') do |f|
      f.puts(text)
    end
    puts "Created: #{file_path}"
    refresh if defined?(refresh)
  rescue => e
    puts "Append failed: #{e.message}"
  end
end
