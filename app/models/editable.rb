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
    extension = File.extname(path)[1..-1]
    Mode[extension] || extension
  end
end
