# /home/katcv/rubian/3_1_0/bin/aliases.rb

$rubian_aliases = {}

def add_alias(name, command)
  if name.nil? || command.nil?
    puts "Usage: add_alias 'name' 'command'"
    return
  end
  
  $rubian_aliases[name] = command
  puts "Alias created: #{name} -> #{command}"
end

def list_aliases
  if $rubian_aliases.empty?
    puts "No aliases defined"
  else
    puts "\n=== ALIASES ==="
    $rubian_aliases.each { |k, v| puts "  #{k} -> #{v}" }
  end
end

def remove_alias(name)
  if $rubian_aliases.delete(name)
    puts "Removed alias: #{name}"
  else
    puts "Alias not found: #{name}"
  end
end
