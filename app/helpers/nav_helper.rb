module NavHelper
  def nav_link(path, name, icon_class, options = {})
    classes = ["nav-item text-center m-2"]  # Add "bg-gray-400" for grey background

    content_tag :li, class: classes do
      link_to path, options.merge({ class: "navbar-item #{'selected-navbar' if current_page?(path)}" }) do
        concat content_tag(:i, "", class: "fa fa-xl #{icon_class} m-2")
        concat content_tag(:span, name, class: "fw-bold")
      end
    end
  end
end
