class DirTree
  attr_reader :dir, :path

  EXCLUDES = %w{. .. .git .keep}

  def initialize(path)
    @path = path
    @dir = Dir.open path
  end

  def display_name
    File.basename path
  end

  def entries
    @entries ||= dir.reject do |e|
      EXCLUDES.include? e
    end.map do |e|
      candidate_path = File.join path, e
      candidate_stat = File.stat candidate_path
      if candidate_stat.directory?
        self.class.new candidate_path
      elsif candidate_stat.file?
        Editable.new candidate_path
      else
        nil
      end
    end.compact
  end
end
