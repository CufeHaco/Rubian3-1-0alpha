# ============================================
# File 3: /home/katcv/rubian/3_1_0/bin/version.rb
# ============================================

module Rubian3

  if defined?($rubian_files) && $rubian_files
    current_boot = $rubian_files.find { |f| f.end_with?('/boot.rb') && f.include?(File.basename(Dir.pwd)) }

    if current_boot
      version_dir = File.basename(File.dirname(current_boot))
      version_num = version_dir.gsub('_', '.')
      $version = "RUBIAN ALPHA VERSION #{version_num}"
    else
      version_dir = File.basename(Dir.pwd)
      version_num = version_dir.gsub('_', '.')
      $version = "RUBIAN ALPHA VERSION #{version_num}"
    end
  else
    version_dir = File.basename(Dir.pwd)
    version_num = version_dir.gsub('_', '.')
    $version = "RUBIAN ALPHA VERSION #{version_num}"
  end

  $ruby_version = "#{`ruby -v`.chomp}"

  class Error < StandardError; end

end
