# /rubian/3_1_0/bin/local_bin_files.rb

def local_bin_files(show_status: true)
  puts "\n=== LOCAL BIN FILES (Current Version) ==="
  puts "Version: #{File.basename(Dir.pwd)}"
  puts "Total files: #{$local_bin_files.length}\n"
  
  if show_status
    $local_bin_files.each_with_index do |filepath, index|
      filename = File.basename(filepath)
      is_loaded = $LOADED_FEATURES.any? { |f| File.expand_path(f) == File.expand_path(filepath) }
      status = is_loaded ? "[LOADED]" : "[      ]"
      size = File.size(filepath) rescue 0
      size_str = format_size(size)
      
      puts "  [#{index}] #{status} #{filename.ljust(30)} #{size_str.rjust(8)}"
    end
  else
    $local_bin_files.each_with_index do |filepath, index|
      filename = File.basename(filepath)
      puts "  [#{index}] #{filename}"
    end
  end
  
  puts "\nUse: local_bin_files(show_status: false) for simple list"
  $local_bin_files
end

def format_size(bytes)
  return "0 B" if bytes == 0
  
  units = ['B', 'KB', 'MB', 'GB']
  exp = (Math.log(bytes) / Math.log(1024)).to_i
  exp = [exp, units.length - 1].min
  
  "%.1f %s" % [bytes / (1024.0 ** exp), units[exp]]
end
