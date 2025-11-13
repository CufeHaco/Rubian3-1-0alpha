# /rubian/3_1_0/bin/touch.rb

def touch(*files)
  if files.empty?
    puts "Usage: touch 'file1' ['file2' ...]"
    return
  end
  
  files.each do |filename|
    # If it has a path, use it as-is
    file_path = if filename.include?('/')
                  filename
                else
                  File.join(Dir.pwd, filename)
                end
    
    if File.exist?(file_path)
      # Update timestamp if file exists
      File.utime(Time.now, Time.now, file_path)
      puts "Updated: #{file_path}"
    else
      # Create new file
      File.open(file_path, 'w') {}
      puts "Created: #{file_path}"
    end
  end
  
  refresh if defined?(refresh)
end
