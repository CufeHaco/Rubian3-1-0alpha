# /home/katcv/rubian/3_1_0/bin/jobs.rb

$rubian_jobs = []

def jobs
  if $rubian_jobs.empty?
    puts "No background jobs"
  else
    puts "\n=== BACKGROUND JOBS ==="
    $rubian_jobs.each_with_index do |job, index|
      status = job[:thread].alive? ? "Running" : "Done"
      puts "[#{index}] #{status} - #{job[:command]}"
    end
  end
end
