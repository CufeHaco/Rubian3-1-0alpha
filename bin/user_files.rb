# /rubian/3_1_0/bin/user_files.rb

def user_files(filter = nil, limit: 50)
  puts "\n=== USER FILES ==="
  puts "Total files: #{$user_files.length}"
  
  # Categorize by location
  home_files = []
  desktop_files = []
  documents_files = []
  downloads_files = []
  rubian_files_list = []
  other_files = []
  
  $user_files.each do |filepath|
    next unless File.file?(filepath)  # Skip directories
    
    case filepath
    when /\/rubian\//
      rubian_files_list << filepath
    when /\/Desktop\//i
      desktop_files << filepath
    when /\/Documents\//i
      documents_files << filepath
    when /\/Downloads\//i
      downloads_files << filepath
    when /^\/home\/#{ENV['USER']}\/[^\/]+$/
      home_files << filepath
    else
      other_files << filepath
    end
  end
  
  # Apply filter
  case filter
  when :home, 'home'
    show_user_files("HOME DIRECTORY", home_files, limit)
  when :desktop, 'desktop'
    show_user_files("DESKTOP", desktop_files, limit)
  when :documents, 'documents', :docs
    show_user_files("DOCUMENTS", documents_files, limit)
  when :downloads, 'downloads'
    show_user_files("DOWNLOADS", downloads_files, limit)
  when :rubian, 'rubian'
    show_user_files("RUBIAN", rubian_files_list, limit)
  when :other, 'other'
    show_user_files("OTHER", other_files, limit)
  else
    # Show summary
    puts "\n--- BY LOCATION ---"
    puts "  Rubian:    #{rubian_files_list.length} files"
    puts "  Home:      #{home_files.length} files"
    puts "  Desktop:   #{desktop_files.length} files"
    puts "  Documents: #{documents_files.length} files"
    puts "  Downloads: #{downloads_files.length} files"
    puts "  Other:     #{other_files.length} files"
    puts "\nUse: user_files :location"
    puts "Options: home, desktop, documents, downloads, rubian, other"
  end
  
  # Return categorized hash
  {
    rubian: rubian_files_list,
    home: home_files,
    desktop: desktop_files,
    documents: documents_files,
    downloads: downloads_files,
    other: other_files,
    total: $user_files.length
  }
end

def show_user_files(category, files, limit)
  puts "\n--- #{category} (#{files.length} files) ---"
  
  if files.length > limit
    puts "Showing first #{limit} of #{files.length} files..."
    files = files.first(limit)
  end
  
  files.each_with_index do |file, index|
    filename = File.basename(file)
    dirname = File.dirname(file).gsub("/home/#{ENV['USER']}/", "~/")
    size = File.size(file) rescue 0
    size_str = format_size(size)
    
    puts "  [#{index}] #{filename.ljust(30)} #{size_str.rjust(10)} #{dirname}"
  end
end

def format_size(bytes)
  return "0 B" if bytes == 0
  
  units = ['B', 'KB', 'MB', 'GB']
  exp = (Math.log(bytes) / Math.log(1024)).to_i
  exp = [exp, units.length - 1].min
  
  "%.1f %s" % [bytes / (1024.0 ** exp), units[exp]]
end
