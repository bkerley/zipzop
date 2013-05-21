class Editable
  attr_reader :relative_path
  def initialize(pow, path='')
    @pow = pow
    @relative_path = path
  end

  def as_json(opts={})
    {
      display_name: display_name,
      mode: mode,
      binary: binary?
    }
  end

  def path
    File.join @pow.path, relative_path
  end

  def basename
    File.basename path
  end

  alias_method :display_name, :basename

  def dirname
    File.dirname relative_path
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

  def mime_type
    return @mime_type if defined? @mime_type
    
    candidate = MIME::Types.type_for(basename).first
    return @mime_type = candidate unless candidate.nil?

    return @mime_type = MIME::Types['text/plain'].first
  end

  def binary?
    audio? || image? || video?
  end

  def audio?
    mime_type.media_type == 'audio'
  end

  def image?
    mime_type.media_type == 'image'
  end

  def video?
    mime_type.media_type == 'video'
  end

  private
  def special_file
    return case File.basename(path)
    when 'Gemfile'
      'ruby'
    when 'Rakefile'
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
