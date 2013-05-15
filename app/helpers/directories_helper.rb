module DirectoriesHelper
  def directory_entry(e)
    case e
    when DirTree
      return content_tag :li, class: 'dir' do
        content_tag(:div, e.display_name, class: 'name') +
        content_tag(:ul, class: 'contents') do 
          e.entries.map {|i| directory_entry i }.join.html_safe
        end
      end
    when Editable
      return content_tag :li, class: 'file' do
        content_tag :div, e.display_name, class: 'name'
      end
    end
  end
end
