# /rubian/3_1_0/bin/user_dirs.rb

def user_dirs(filter = nil)
  puts "\n=== USER DIRECTORIES ==="
  puts "Total directories: #{$user_dirs.length}"
  
  # Categorize common directories
  common_dirs = {
    home: [],
    desktop: [],
    documents: [],
    downloads: [],
    rubian: [],
    hidden: [],
    other: []
  }
  
  $user_dirs.each do |dir|
    case dir
    when /\/rubian\//
      common_dirs[:rubian] << dir
    when /\/Desktop\//i
      common_dirs[:desktop] << dir
    when /\/Documents\//i
      common_dirs[:documents] << dir
    when /\/Downloads\//i
      common_dirs[:downloads] << dir
    when /^\/home\/#{ENV['USER']}\/$/
      common_dirs[:home] << dir
    when /\/\.[^\/]+\//
      common_dirs[:hidden] << dir
    else
      common_dirs[:other] << dir
    end
  end
  
  if filter
    category = filter.to_sym
    if common_dirs.key?(category)
      show_user_dirs(category.to_s.upcase, common_dirs[category])
    else
      puts "Unknown filter: #{filter}"
      puts "Available: #{common_dirs.keys.join(', ')}"
    end
  else
    puts "\n--- BY LOCATION ---"
    common_dirs.each do |category, dirs|
      next if dirs.empty?
      puts "  #{category.to_s.capitalize.ljust(12)}: #{dirs.length} directories"
    end
    puts "\nUse: user_dirs :category"
    puts "Options: #{common_dirs.keys.join(', ')}"
  end
  
  common_dirs.merge(total: $user_dirs.length)
end

def show_user_dirs(category, dirs)
  puts "\n--- #{category} (#{dirs.length}) ---"
  dirs.each_with_index do |dir, index|
    dir_display = dir.gsub("/home/#{ENV['USER']}/", "~/")
    item_count = Dir.glob("#{dir}*").length rescue 0
    puts "  [#{index}] #{dir_display.ljust(50)} (#{item_count} items)"
  end
end
