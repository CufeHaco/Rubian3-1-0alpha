#!/usr/bin/env ruby

def rubian_files(filter = nil)
  # Categorize files
  bootstrap_files = []
  repl_files = []
  loaded_files = []
  unloaded_files = []
  available_files = []

  current_version = File.basename(Dir.pwd)

  $rubian_files.each do |filepath|
    filename = File.basename(filepath)
    is_loaded = $LOADED_FEATURES.any? { |f| File.expand_path(f) == File.expand_path(filepath) }
    is_current_version = filepath.include?("/rubian/#{current_version}/")
    is_boot = filename == "boot.rb"
    is_repl = filename == "rubian3.rb"

    if is_repl
      repl_files << filepath
    elsif is_boot && is_current_version
      bootstrap_files << filepath
    elsif is_loaded
      loaded_files << filepath
    elsif is_current_version
      unloaded_files << filepath
    else
      available_files << filepath
    end
  end

  # Display output
  if filter.nil? || filter == :all || filter == 'all'
    puts "\n=== RUBIAN FILES ==="
    puts "Total files: #{$rubian_files.length}\n"
    show_files("BOOTSTRAP (Boot File)", bootstrap_files)
    puts ""
    show_files("REPL (Current Shell)", repl_files)
    puts ""
    show_files("LOADED (Required)", loaded_files)
    puts ""
    show_files("UNLOADED (Current Version)", unloaded_files)
    puts ""
    show_files("AVAILABLE (Other Versions)", available_files)
  else
    puts "\n=== RUBIAN FILES ==="
    puts "Total files: #{$rubian_files.length}\n"
    case filter
    when :bootstrap, 'bootstrap'
      show_files("BOOTSTRAP (Boot File)", bootstrap_files)
      return bootstrap_files
    when :repl, 'repl'
      show_files("REPL (Current Shell)", repl_files)
      return repl_files
    when :loaded, 'loaded'
      show_files("LOADED (Required)", loaded_files)
      return loaded_files
    when :unloaded, 'unloaded'
      show_files("UNLOADED (Current Version)", unloaded_files)
      return unloaded_files
    when :available, 'available'
      show_files("AVAILABLE (Other Versions)", available_files)
      return available_files
    else
      puts "Invalid filter: #{filter}"
      return nil
    end
  end

  # Return $rubian_files for no filter or :all
  $rubian_files
end

def show_files(category, files)
  puts "--- #{category} (#{files.length}) ---"
  files.each_with_index do |file, index|
    filename = File.basename(file)
    dirname = File.dirname(file).gsub("/home/#{ENV['USER']}/", "~/")
    puts "  [#{index}] #{filename.ljust(25)} #{dirname}"
  end
end
