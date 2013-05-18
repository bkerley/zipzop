class Editable
  attr_reader :relative_path
  def initialize(pow, path='')
    @pow = pow
    @relative_path = path
  end

  def path
    File.join @pow.path, relative_path
  end

  def display_name
    File.basename path
  end

  def read
    File.read path
  end

  def mode
    if special = special_file
      return special
    end
    extension = File.extname(path)[1..-1]
    Mode[extension]
  end

  private
  def special_file
    return case File.basename(path)
    when 'Gemfile'
      'ruby'
    when '.ruby-version'
      'text'
    when '.gitignore'
      'text'
    else
      false
    end
  end
end
