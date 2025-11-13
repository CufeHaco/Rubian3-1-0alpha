# /home/katcv/rubian/3_1_0/bin/seq.rb

def seq(start, finish = nil, step = 1)
  if finish.nil?
    finish = start
    start = 1
  end
  
  (start..finish).step(step).each { |i| puts i }
end
