module PowsHelper
  def directory_entry(e)
    case e
    when DirTree
      return directory_entry_folder e
    when Editable
      return directory_entry_file e
    end
  end

  def directory_entry_folder(e)
    content_tag :li, class: 'folder' do
      content_tag(:div, class: 'dir name') do
        e.display_name
      end +
      content_tag(:ul, class: 'contents') do 
        e.entries.map {|i| directory_entry i }.join.html_safe
      end
    end
  end

  def directory_entry_file(e)
    content_tag :li, class: file_css_class(e) do
      content_tag :div, class: 'file name' do
        if e.binary?
          e.display_name
        else
          file_link(e)
        end
      end
    end
  end

  def file_link(entry)
    link_to entry.display_name, pow_edit_path(pow_id: pow_id, id: entry.relative_path)
  end

  def file_css_class(e)
    Rails.logger.info e.display_name
    content_type = e.mime_type.content_type
    full_type = "mime_" + content_type.gsub('/', '_')
    media_type = "mime_media_" + e.mime_type.media_type
    name = "name_" + e.basename.gsub('.', '_')
    mode = "mode_" + e.mode rescue ''
    binary = "binary_" + e.binary?.inspect

    ['file', full_type, media_type, name, mode, binary].join ' '
  end

  def pow_link
    link_to pow.name, pow_path(pow.name)
  end
end
