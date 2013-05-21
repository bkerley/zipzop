class Pow
  attr_reader :name
  POW_PATH = File.join(ENV['HOME'], '.pow')

  def self.list
    (Dir.entries(POW_PATH) - DirTree::EXCLUDES).map do |name|
      Pow.new name
    end
  end

  def as_json(opts={})
    opts[:exclude] ||= []
    return {name: name, broken: true} if broken?
    base = {name: name}
    base[:tree] = tree unless opts[:exclude].include? :tree
    base
  end

  def initialize(name)
    @name = name
  end

  def broken?
    !File::Stat.new(path) rescue true
  end

  def editable(edit_path)
    Editable.new self, edit_path
  end

  def tree
    DirTree.new self, '', ''
  end

  def path
    File.join(POW_PATH, name)
  end
end
