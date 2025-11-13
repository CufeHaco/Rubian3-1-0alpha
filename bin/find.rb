def find(pattern)
  if pattern.nil? || pattern.empty?
    puts "Usage: find 'pattern'"
    return
  end
  
  matches = []
  
  # Search rubian files first
  matches += $rubian_files.select { |f| f.include?(pattern) }
  
  # Search user files if needed
  if matches.empty?
    matches += $user_files.select { |f| f.include?(pattern) }
  end
  
  if matches.any?
    puts "Found #{matches.length} matches:"
    matches.each_with_index { |f, i| puts "  [#{i}] #{f}" }
  else
    puts "No files found matching: #{pattern}"
  end
  
  matches
end
