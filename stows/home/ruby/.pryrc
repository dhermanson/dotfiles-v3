if ENV['INSIDE_EMACS']
  Pry.config.correct_indent = false
  Pry.config.pager = false
end
Pry.config.pager = false
# Pry.config.color = true

# do this per project in local .pryrc
# Pry.config.prompt_name = "pry:#{project_name}"
# Pry.config.prompt_name = "pry@#{File.basename(Dir.pwd)}"

# Pry.config.prompt = proc { |obj, nest_level, pry| "#{Dir.pwd}\npry(#{obj}:#{nest_level})> " }
