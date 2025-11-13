# /home/katcv/rubian/3_1_0/bin/curl.rb

def curl(url)
  if url.nil? || url.empty?
    puts "Usage: curl 'url'"
    return
  end

  system("curl #{url}")
end
