class Editable
  attr_reader :path
  def initialize(path)
    @path = path
  end

  def read
    File.read @path
  end
end
