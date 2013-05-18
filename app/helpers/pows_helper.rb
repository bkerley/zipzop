module PowsHelper
  def directory_entry(e)
    case e
    when DirTree
      return content_tag :li do
        content_tag(:div, class: 'dir name') do
          directory_link(e)
        end +
        content_tag(:ul, class: 'contents') do 
          e.entries.map {|i| directory_entry i }.join.html_safe
        end
      end
    when Editable
      return content_tag :li do
        content_tag :div, class: 'file name' do
          file_link(e)
        end
      end
    end
  end

  def directory_link(entry)
    content_tag :a, entry.display_name, href: 'fart'
  end

  def file_link(entry)
    link_to entry.display_name, pow_edit_path(pow_id: pow_id, id: entry.relative_path)
  end
end
