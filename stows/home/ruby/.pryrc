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



# https://dev.to/thiagoa/ruby-and-emacs-tip-advanced-pry-integration-33bk

# The function accepts an arbitrary path
def emacs_open_in_dired(path)
  system %{emacsclient -e '(dired-jump nil "#{path}")'}
end

def gem_dir(gem_name)
  gem_dir = Gem::Specification.find_by_name(gem_name).gem_dir 
  Pathname(gem_dir)
end

# This is a shorthand to create and add a command at the same time
Pry::Commands.create_command 'ggem' do
  description 'Open a gem dir in Emacs dired'
  banner <<-'BANNER'
  Usage: ggem GEM_NAME

  Example: ggem propono
  BANNER

  def process
    gem_name = args.join('')

    # Opens the gem's lib folder in Dired
    emacs_open_in_dired gem_dir(gem_name) / 'lib'
  rescue Gem::MissingSpecError
    # do nothing
  end
end

