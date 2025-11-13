# /home/katcv/rubian/3_1_0/bin/env.rb

def env(var = nil)
  if var
    puts ENV[var] || "#{var} not set"
  else
    ENV.each { |k, v| puts "#{k}=#{v}" }
  end
end
