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
end
