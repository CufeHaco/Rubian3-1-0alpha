# /rubian/3_1_0/bin/quick_write.rb

def quick_write(string)
  editor = Rubian3::Texteditor.new
  editor.texteditor2(string)  # Use Reline (multiline)
end

# Alias for convenience
alias qw quick_write
