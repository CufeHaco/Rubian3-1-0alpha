def make_cmd(filename)
  # Build path to version-specific cmd directory
  current_version = File.basename(Dir.pwd)
  cmd_dir = "/home/#{ENV['USER']}/rubian/#{current_version}/bin/cmd"
  Dir.mkdir(cmd_dir) unless Dir.exist?(cmd_dir)
  
  filepath = "#{cmd_dir}/#{filename}"
  
  # Check arrays for conflicts
  existing = $rubian_files.find { |f| f.end_with?(filename) }
  if existing
    puts "Warning: #{filename} already exists at #{existing}"
    print "Overwrite? (y/n): "
    return unless gets.chomp.downcase == 'y'
  end

  # Reuse existing Texteditor module (DRY!)
  editor = Rubian3::Texteditor.new
  editor.texteditor2(filepath)
  
  # Refresh and load
  refresh if defined?(refresh)
  boot = Rubian3::Boot.new
  boot.rubian_boot(filename)
  puts "Command loaded: #{filename}"
end
