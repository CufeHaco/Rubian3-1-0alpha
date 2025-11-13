#!/usr/bin/env ruby

def ls(target = nil)
  # Determine directory to list
  dir_path = if target.nil?
               Dir.pwd
             elsif Dir.exist?(target)
               target
             else
               $rubian_dirs.find { |d| d.end_with?("#{target}/") } ||
               $user_dirs.find { |d| d.end_with?("#{target}/") } || Dir.pwd
             end

  unless Dir.exist?(dir_path)
    puts "\n--- LS OUTPUT (0 dirs, 0 files) ---"
    puts "#{target} not found!"
    return nil
  end

  entries = Dir.entries(dir_path)
  dirs = []
  files = []

  entries.each do |entry|
    next if entry == '.' || entry == '..'
    full_path = File.join(dir_path, entry)

    if File.directory?(full_path)
      dirs << { name: entry, path: full_path }
    else
      size = File.size(full_path) rescue 0
      files << { name: entry, size: size, path: full_path }
    end
  end

  # Display output
  puts "\n--- LS OUTPUT (#{dirs.length} dirs, #{files.length} files) ---"
  puts "Listing: #{dir_path.gsub("/home/#{ENV['USER']}/", "~/")}"

  if dirs.any?
    puts "--- Directories ---"
    dirs.sort_by { |d| d[:name] }.each_with_index do |dir, index|
      dirname = dir[:path].gsub("/home/#{ENV['USER']}/", "~/")
      marker = $rubian_dirs.include?(dir[:path]) ? "[Rubian] " : ""
      puts "[#{index}] #{marker}#{dir[:name]}/".ljust(25) + " #{dirname}"
    end
  end

  if files.any?
    puts "--- Files ---"
    files.sort_by { |f| f[:name] }.each_with_index do |file, index|
      size_str = format_size(file[:size])
      dirname = file[:path].gsub("/home/#{ENV['USER']}/", "~/")
      marker = $rubian_files.include?(file[:path]) ? "[Rubian] " : ""
      puts "[#{index}] #{marker}#{file[:name].ljust(25)} #{dirname} #{size_str.rjust(10)}"
    end
  end

  if dirs.empty? && files.empty?
    puts "No files or directories found."
  end

  # Return combined list for scripting
  dirs.map { |d| d[:name] } + files.map { |f| f[:name] }
end

def format_size(bytes)
  return "0 B" if bytes == 0
  units = ['B', 'KB', 'MB', 'GB']
  exp = (Math.log(bytes) / Math.log(1024)).to_i
  exp = [exp, units.length - 1].min
  "%.1f %s" % [bytes / (1024.0 ** exp), units[exp]]
end
