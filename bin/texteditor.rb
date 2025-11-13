# /rubian/3_1_0/bin/texteditor.rb

require 'readline'

module Rubian3
  class Texteditor
    
    # Single-line quick editor (Readline)
    def texteditor(filename)
      file_path = resolve_file_path_with_prompt(filename)
      return unless file_path  # User cancelled
      
      # Delete existing file if found
      if File.exist?(file_path)
        File.delete(file_path)
      end
      
      file = File.new(file_path, 'w')
      puts "Quick editor (Readline) - Type 'exit' to save and quit"
      
      while text = Readline.readline('> ', true)
        if text == 'exit'
          file.close
          puts "File saved: #{file_path}"
          
          # Try to hot-load if it's a Ruby file
          if file_path.end_with?('.rb')
            hot_load = Rubian3::Boot.new if defined?(Rubian3::Boot)
            hot_load&.rubian_boot(File.basename(file_path))
            puts "#{File.basename(file_path)} :required!"
          end
          
          # Refresh arrays
          refresh if defined?(refresh)
          break
        end
        file.puts(text)
      end
    end
    
    private
    
    def resolve_file_path_with_prompt(filename)
      # If it has a path separator, use it as-is (explicit path)
      return filename if filename.include?('/')
      
      # Check pwd first
      pwd_path = File.join(Dir.pwd, filename)
      
      # Search for all matches in arrays
      matches = []
      if defined?($rubian_files) && $rubian_files
        matches += $rubian_files.select { |f| File.basename(f) == filename }
        matches += $user_files.select { |f| File.basename(f) == filename } if defined?($user_files)
      end
      
      # Remove duplicates and the pwd path if it exists
      matches.uniq!
      matches.reject! { |m| m == pwd_path }
      
      # If no matches found anywhere, just create in pwd
      return pwd_path if matches.empty?
      
      # If matches found, show prompt
      puts "\nWARNING: Found #{matches.length} existing file(s) named '#{filename}':"
      puts ""
      
      matches.each_with_index do |match, i|
        dir = File.dirname(match).gsub("/home/#{ENV['USER']}/", "~/")
        puts "  [#{i + 1}] #{dir}/#{filename}"
      end
      
      puts "  [#{matches.length + 1}] Create new in current directory (#{Dir.pwd.gsub("/home/#{ENV['USER']}/", "~/")})"
      puts "  [0] Cancel"
      puts ""
      
      print "Choose option (0-#{matches.length + 1}): "
      choice = gets.chomp.to_i
      
      case choice
      when 0
        puts "Cancelled."
        return nil
      when 1..matches.length
        return matches[choice - 1]
      when matches.length + 1
        return pwd_path
      else
        puts "Invalid choice. Creating in current directory."
        return pwd_path
      end
    end
  end
end

$editor = Rubian3::Texteditor.new
