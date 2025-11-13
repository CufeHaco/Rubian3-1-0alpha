# /rubian/3_1_0/bin/cp.rb

require 'fileutils'

def cp(source, dest)
  # Resolve source path
  source_path = if File.exist?(source)
                  source
                else
                  $rubian_files.find { |f| f.end_with?(source) } ||
                  $user_files.find { |f| f.end_with?(source) } ||
                  source
                end
  
  unless File.exist?(source_path)
    puts "#{source} not found!"
    return
  end
  
  # Resolve destination path
  dest_path = if dest.include?('/')
                dest
              elsif Dir.exist?(dest)
                dest
              else
                # If dest is just a name, put it in pwd
                File.join(Dir.pwd, dest)
              end
  
  # If destination is a directory, keep source filename
  if Dir.exist?(dest_path)
    dest_path = File.join(dest_path, File.basename(source_path))
  end
  
  begin
    FileUtils.cp(source_path, dest_path)
    puts "Copied: #{File.basename(source_path)} -> #{dest_path}"
    refresh if defined?(refresh)
  rescue Errno::EACCES
    puts "Permission denied. Try with sudo?"
  rescue => e
    puts "Copy failed: #{e.message}"
  end
end
