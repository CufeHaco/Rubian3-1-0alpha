# /rubian/3_1_0/bin/quick_note.rb

def quick_note(string)
  editor = Rubian3::Texteditor.new
  editor.texteditor(string)  # Use Readline (single-line)
end

# Alias for convenience
alias qn quick_note
