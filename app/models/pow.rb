class Pow
  attr_reader :name
  POW_PATH = File.join(ENV['HOME'], '.pow')

  def initialize(name)
    @name = name
  end
  def editable(path)
    Editable.new File.join(POW_PATH, name, path)
  end
end
