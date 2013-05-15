class Pow
  attr_reader :name
  POW_PATH = File.join(ENV['HOME'], '.pow')

  def initialize(name)
    @name = name
  end
  def editable(edit_path)
    Editable.new File.join(path, edit_path)
  end
  def tree
    DirTree.new path
  end

  def path
    File.join(POW_PATH, name)
  end
end
