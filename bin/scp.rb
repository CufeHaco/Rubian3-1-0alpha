# /home/katcv/rubian/3_1_0/bin/scp.rb

def scp(source, destination)
  if source.nil? || destination.nil?
    puts "Usage: scp 'source' 'destination'"
    puts "Example: scp 'file.txt' 'user@host:/path/'"
    puts "Example: scp 'user@host:/path/file.txt' '.'"
    return
  end
  
  # Resolve local source if needed
  if !source.include?('@') && !File.exist?(source)
    source = $rubian_files.find { |f| f.end_with?(source) } ||
             $user_files.find { |f| f.end_with?(source) } ||
             source
  end
  
  system("scp #{source} #{destination}")
  refresh if defined?(refresh)
end
