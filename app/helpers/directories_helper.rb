module DirectoriesHelper
  def directory_entry(e)
    case e
    when DirTree
      return content_tag :li, class: 'dir' do
        content_tag(:div, class: 'name') do
          directory_link(e)
        end +
        content_tag(:ul, class: 'contents') do 
          e.entries.map {|i| directory_entry i }.join.html_safe
        end
      end
    when Editable
      return content_tag :li, class: 'file' do
        content_tag :div, class: 'name' do
          file_link(e)
        end
      end
    end
  end

  def directory_link(entry)
    content_tag :a, entry.display_name, href: 'fart'
  end

  def file_link(entry)
    link_to entry.display_name, pow_edit_path(id: entry.relative_path)
  end
end
