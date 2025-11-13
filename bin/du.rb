# /home/katcv/rubian/3_1_0/bin/du.rb

def du(path = nil, depth = 1)
  target = path || Dir.pwd
  
  # Resolve using arrays
  dir_path = if Dir.exist?(target)
               target
             else
               $rubian_dirs.find { |d| d.end_with?("#{target}/") } ||
               $user_dirs.find { |d| d.end_with?("#{target}/") }
             end
  
  if dir_path && Dir.exist?(dir_path)
    system("du -h --max-depth=#{depth} #{dir_path}")
  else
    puts "#{target} not found!"
  end
end
