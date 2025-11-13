# /home/katcv/rubian/3_1_0/bin/rsync.rb

def rsync(source, destination, options = '-avz')
  if source.nil? || destination.nil?
    puts "Usage: rsync 'source' 'destination' [options]"
    puts "Example: rsync '/path/to/source' 'user@host:/dest/'"
    return
  end
  
  # Resolve local source
  if !source.include?('@') && Dir.exist?(source)
    source_path = source
  elsif !source.include?('@')
    source_path = $rubian_dirs.find { |d| d.end_with?("#{source}/") } ||
                  $user_dirs.find { |d| d.end_with?("#{source}/") } ||
                  source
  else
    source_path = source
  end
  
  system("rsync #{options} #{source_path} #{destination}")
  refresh if defined?(refresh)
end
