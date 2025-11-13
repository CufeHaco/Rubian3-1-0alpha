# /home/katcv/rubian/3_1_0/bin/diff.rb

def diff(file1, file2)
  if file1.nil? || file2.nil?
    puts "Usage: diff 'file1' 'file2'"
    return
  end
  
  path1 = if File.exist?(file1)
            file1
          else
            $rubian_files.find { |f| f.end_with?(file1) } ||
            $user_files.find { |f| f.end_with?(file1) }
          end
  
  path2 = if File.exist?(file2)
            file2
          else
            $rubian_files.find { |f| f.end_with?(file2) } ||
            $user_files.find { |f| f.end_with?(file2) }
          end
  
  if path1.nil?
    puts "#{file1} not found!"
    return
  end
  
  if path2.nil?
    puts "#{file2} not found!"
    return
  end
  
  system("diff #{path1} #{path2}")
end 
