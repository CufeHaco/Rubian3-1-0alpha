# /home/katcv/rubian/3_1_0/bin/wget.rb

def wget(url, output = nil)
  if url.nil? || url.empty?
    puts "Usage: wget 'url' [output_filename]"
    return
  end

  if output
    system("wget -O #{output} #{url}")
  else
    system("wget #{url}")
  end

  refresh if defined?(refresh)
end
