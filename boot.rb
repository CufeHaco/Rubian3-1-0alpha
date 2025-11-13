# /rubian/3_1_0/boot.rb

module Rubian3
  class Boot
    def initialize
      $user_dirs    = []
      $user_files   = []
      $rubian_dirs  = []
      $rubian_files = []
      $local_bin_files = []
      @boot_order   = []
      @current_version_dir = File.basename(Dir.pwd)
    end

    def boot_glob
      $user_dirs    = Dir.glob("/home/#{ENV['USER']}/**/")
      
      # Fix: Filter to files only (exclude directories)
      all_user_paths = Dir.glob("/home/#{ENV['USER']}/**/*")
      $user_files = all_user_paths.select { |path| File.file?(path) }
      
      $rubian_dirs  = Dir.glob("/home/#{ENV['USER']}/rubian/**/")
      $rubian_files = Dir.glob("/home/#{ENV['USER']}/rubian/**/*.rb")

      # Get local bin files for this version (e.g., 3_1_0/bin/*.rb)
      $local_bin_files = Dir.glob("/home/#{ENV['USER']}/rubian/#{@current_version_dir}/bin/*.rb")
    end

    def generate_boot_order
      @boot_order = []

      # First, add local bin files (version-specific overrides)
      $local_bin_files.each do |filepath|
        filename = File.basename(filepath)
        next if filename == "rubian3.rb"
        @boot_order << filename
      end

      # Then add global rubian files (if not already loaded from local)
      $rubian_files.each do |filepath|
        filename = File.basename(filepath)

        # Skip old versions and boot files
	next if filepath.include?("3_2_3") || filepath.end_with?("/boot.rb")
	next if filepath.include?("3_2_2") || filepath.end_with?("/boot.rb")
	next if filepath.include?("3_2_1") || filepath.end_with?("/boot.rb")
	next if filepath.include?("3_2_0") || filepath.end_with?("/boot.rb")
        next if filepath.include?("3_0_0") || filepath.end_with?("/boot.rb")
        next if filename == "rubian3.rb"
        next if @boot_order.include?(filename)  # Skip if already loaded from local bin

        @boot_order << filename
      end

      # Always add rubian3.rb last
      @boot_order << "rubian3.rb"
      @boot_order
    end

    def rubian_boot(file)
      local_bin_path = "/home/#{ENV['USER']}/rubian/#{@current_version_dir}/bin/#{file}"

      # Try local bin first
      if File.exist?(local_bin_path)
        begin
          @load_path = local_bin_path
          @dir_path  = File.dirname(local_bin_path)
          puts "Successfully required (local): #{@load_path}"
          require @load_path
          return true
        rescue => e
          puts "Error loading local #{file}: #{e.message}"
          puts "Falling back to global search..."
        end
      end

      # Fallback to global search - BUT filter by priority
      search_paths = [
        # Priority 1: Current version global bin
        "/home/#{ENV['USER']}/rubian/bin/",
        # Priority 2: Etc directory
        "/home/#{ENV['USER']}/rubian/etc/",
        # Priority 3: Any rubian directory EXCEPT old versions
      ]

      file_found = false

      # Try priority paths first
      search_paths.each do |path|
        full_path = "#{path}#{file}"
        if File.exist?(full_path)
          @dir_path  = File.dirname(full_path)
          @load_path = full_path
          puts "Successfully required: #{@load_path}"
          require @load_path
          file_found = true
          break
        end
      end

      # If still not found, do filtered global search
      unless file_found
        find_self = Dir.glob("/home/#{ENV['USER']}/rubian/**/")

        # Filter OUT old versions
        find_self.reject! { |dir| dir.include?("3_0_0") }

        find_self.each do |value|
          check_self = File.exist?("#{value}#{file}")
          if check_self == true
            @dir_path  = File.dirname("#{value}#{file}")
            @load_path = value + file
            puts "Successfully required: #{@load_path}"
            require @load_path
            file_found = true
            break
          end
        end
      end

      unless file_found
        puts "File not found: #{file}"
      end
    end

    def fallback_boot
      old_boot = "/home/#{ENV['USER']}/rubian/3_0_0/boot.rb"
      if File.exist?(old_boot)
        puts "Main boot failed, using fallback: #{old_boot}"
        require old_boot
      end
    end
  end

  # Aliases for backward compatibility
  Rubian_File_Utils = Boot
  Dynamic_File_Utils = Boot

end

boot = Rubian3::Boot.new
boot.boot_glob

begin
  boot_file = boot.generate_boot_order
  boot_file.each do |file|
    boot.rubian_boot(file)
  end
rescue => e
  puts "Boot error: #{e.message}"
  boot.fallback_boot
end
