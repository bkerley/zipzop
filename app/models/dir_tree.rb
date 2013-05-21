class DirTree
  attr_reader :pow, :dir_path, :relative_path

  EXCLUDES = %w{. .. .git .keep tmp}

  def initialize(pow, dir_path, relative_path)
    @pow = pow
    @dir_path = dir_path
    @relative_path = relative_path
  end

  def as_json(opts={})
    {
      display_name: display_name,
      relative_path: relative_path,
      entries: entries
    }
  end

  def path
    @path ||= File.join pow.path, dir_path, relative_path
  end

  def display_name
    File.basename path
  end

  def entries
    return @entries if defined? @entries
    clean_entries = []
    Dir.open path do |dir|
      clean_entries = dir.reject do |e|
        EXCLUDES.include? e
      end
    end
    @entries = clean_entries.map do |e|
      candidate_path = File.join path, e
      candidate_stat = File.lstat candidate_path
      if candidate_stat.directory?
        self.class.new pow, File.join(dir_path, relative_path), e
      elsif candidate_stat.file?
        Editable.new pow, File.join(dir_path, relative_path, e)
      else
        nil
      end
    end.compact
  end
end
