# Updated for 3_1_0/bin/make_dir.rb
def mkdir(string)
  Dir.mkdir(string)
  puts "Dir: #{string} Created!"
  refresh  # Update arrays to include new directory
end
