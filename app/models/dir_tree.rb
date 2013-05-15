class DirTree
  attr_reader :dir, :pow, :dir_path, :relative_path

  EXCLUDES = %w{. .. .git .keep}

  def initialize(pow, dir_path, relative_path)
    @pow = pow
    @dir_path = dir_path
    @relative_path = relative_path
    @dir = Dir.open path
  end

  def path
    @path ||= File.join pow.path, dir_path, relative_path
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
        [pow.path, relative_path, e].each do |f|
          Rails.logger.info f
        end
        self.class.new pow, relative_path, e
      elsif candidate_stat.file?
        Editable.new candidate_path
      else
        nil
      end
    end.compact
  end
end
