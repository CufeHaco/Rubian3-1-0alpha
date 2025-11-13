# /rubian/3_1_0/bin/copy_cat.rb

require 'fileutils'

def copy_cat(*args)
  if args.empty?
    puts "Usage: copy_cat 'file1|dir1' ['file2|dir2' ...]"
    return
  end

  # Collect all contents in memory
  all_contents = []
  all_files = []

  args.each do |arg|
    path = if File.exist?(arg)
             arg
           else
             $rubian_files.find { |f| f.end_with?(arg) } ||
             $user_files.find { |f| f.end_with?(arg) }
           end

    if path.nil?
      puts "#{arg} not found!"
      next
    end

    if Dir.exist?(path)
      found_files = Dir.glob(File.join(path, '**/*')).select { |f| File.file?(f) }
      all_files.concat(found_files)
    elsif File.file?(path)
      all_files << path
    else
      puts "#{arg} not found!"
    end
  end

  if all_files.empty?
    puts "No files found to copy."
    return
  end

  multiple = all_files.length > 1

  all_files.each do |file_path|
    begin
      file_contents = File.open(file_path, 'rb') { |f| f.read }.force_encoding('ASCII-8BIT')
      display_contents = file_contents.dup.force_encoding('UTF-8').scrub('?')

      if multiple
        puts "\n==> #{file_path} <=="
      end
      puts display_contents

      if multiple
        all_contents << "==> #{file_path} <==\n".force_encoding('ASCII-8BIT')
      end
      all_contents << file_contents
      all_contents << "\n\n".force_encoding('ASCII-8BIT') if multiple
    rescue => e
      puts "Error reading #{file_path}: #{e.message}"
    end
  end

  combined_content = all_contents.join(''.force_encoding('ASCII-8BIT'))

  # Append to clipboard
  clipboard_success = false
  clipboard_get_cmd = nil
  clipboard_set_cmd = nil
  current = ''.force_encoding('ASCII-8BIT')

  if system('which xclip > /dev/null 2>&1')
    clipboard_get_cmd = 'xclip -o -selection clipboard'
    clipboard_set_cmd = 'xclip -selection clipboard'
  elsif system('which xsel > /dev/null 2>&1')
    clipboard_get_cmd = 'xsel -o --clipboard'
    clipboard_set_cmd = 'xsel -i --clipboard'
  elsif system('which clip.exe > /dev/null 2>&1')
    clipboard_get_cmd = 'powershell.exe -command "Get-Clipboard"'
    clipboard_set_cmd = 'clip.exe'
  end

  if clipboard_get_cmd
    IO.popen(clipboard_get_cmd, 'rb') do |pipe|
      current = pipe.read.force_encoding('ASCII-8BIT')
    rescue => e
      puts "Error reading clipboard: #{e.message}"
      current = ''.force_encoding('ASCII-8BIT')
    end
  end

  separator = current.empty? ? ''.force_encoding('ASCII-8BIT') : "\n\n".force_encoding('ASCII-8BIT')
  full_content = current + separator + combined_content

  if clipboard_set_cmd
    IO.popen(clipboard_set_cmd, 'wb') do |pipe|
      pipe.write(full_content)
      pipe.close_write
    end
    clipboard_success = $?.success?
  end

  if clipboard_success
    puts "\n[✓ Appended #{all_files.length} file(s) to clipboard - #{combined_content.bytesize} new bytes]"
  else
    puts "\n[✗ Clipboard append failed. Contents preview (scrubbed):"
    puts combined_content.force_encoding('UTF-8').scrub('?')[0, 500] + '...'
  end
end

# Alias
alias cc copy_cat
