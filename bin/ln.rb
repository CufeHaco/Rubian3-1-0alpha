# /home/katcv/rubian/3_1_0/bin/ln.rb

def ln(source, link_name)
  if source.nil? || link_name.nil?
    puts "Usage: ln 'source' 'link_name'"
    return
  end
  
  source_path = if File.exist?(source)
                  source
                else
                  $rubian_files.find { |f| f.end_with?(source) } ||
                  $user_files.find { |f| f.end_with?(source) }
                end
  
  if source_path.nil?
    puts "#{source} not found!"
    return
  end
  
  system("ln -s #{source_path} #{link_name}")
  puts "Created symlink: #{link_name} -> #{source_path}"
  refresh if defined?(refresh)
end
