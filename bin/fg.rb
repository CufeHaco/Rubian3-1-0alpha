# /home/katcv/rubian/3_1_0/bin/fg.rb

def fg(job_id = 0)
  $rubian_jobs ||= []
  
  if $rubian_jobs.empty?
    puts "No background jobs"
    return
  end
  
  if job_id >= $rubian_jobs.length
    puts "Invalid job ID: #{job_id}"
    return
  end
  
  job = $rubian_jobs[job_id]
  puts "Bringing to foreground: #{job[:command]}"
  job[:thread].join
  puts "Job completed"
end
