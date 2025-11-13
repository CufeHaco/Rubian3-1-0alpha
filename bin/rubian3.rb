#!/usr/local/bin/env ruby

require 'readline'

stty_save = `stty -g`.chomp

module Rubian_core

  Process.setproctitle("rubian3")
  $0 = 'rubian3'

  def self.find_file(file)
    homedir_array = Dir.glob("/home/**/")
    homedir_array.each_with_index do |value, index|
      a = File.exist?("#{value}#{file}")

      if a == true
        @dir_path = Dir.new(value)
        @load_path = value + file
        puts '@load_path: ' + @load_path
        print '@dir_path: '
        p @dir_path
      end
    end
  end

  def self.pwd
    Dir.pwd
  end

  def self.prompt
    if defined?($sudo) && $sudo.running? == true
      "#{pwd}:> "
    else
      "#{pwd}:> "
    end
  end

end

include Rubian_core
bnd = TOPLEVEL_BINDING

while input = Readline.readline("#{Rubian_core.prompt}", true)

  begin

    result = bnd.eval(input)

    ("#{result} \n")
    STDOUT.flush

    trap("INT", "DEFAULT") { system "stty", stty_save; return input }

  rescue => e
    puts e.message

  rescue SyntaxError => e
    puts e.message

  rescue LoadError => e
    puts e.message

  rescue SignalException => e
    puts e.message

  rescue Exception => e
    puts e.message
    break if input == 'exit'
  end

end
