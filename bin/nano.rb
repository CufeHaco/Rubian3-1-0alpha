require 'shellwords'

# Updated for 3_1_0/bin/nano.rb
def nano(string)
  if string.nil? || string.empty?
    puts "System Error: missing file name."
    puts "nano 'example.txt'"
    return
  end
  
  # Search arrays for existing file
  file_path = if File.exist?(string)
                string
              else
                $rubian_files.find { |f| f.end_with?(string) } ||
                $user_files.find { |f| f.end_with?(string) } ||
                string  # Use as-is if not found (new file)
              end
  
  safe_filename = Shellwords.escape(file_path)
  if system("nano #{safe_filename}")
    puts "System: File saved and nano exited."
    refresh  # Update arrays in case new file was created
  else
    puts "System Error: Nano exited with an error (code #{$?.exitstatus})"
  end
end
