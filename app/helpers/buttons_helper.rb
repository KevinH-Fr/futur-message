module ButtonsHelper
    def custom_submit_button(form, text)
      content_tag(:div, class: "container-fluid p-0") do
        button_tag(type: "submit", class: "btn w-100 btn-outline-success fw-bold") do
          concat content_tag(:i, "", class: "fa-solid fa-xl fa-check-circle me-2")
          concat content_tag(:span, text, class: "fw-bold")
        end
      end
    end
  

  def return_model_index_button(text, path)
    content_tag(:div, class: "m-1 d-flex align-items-center") do
      link_to path, class: "btn btn-outline-secondary fw-bold d-flex align-items-center" do
          content_tag(:i, "", class: "fa-solid fa-xl fa-arrow-left") +
          content_tag(:span, text, class: "ms-2")
      end
    end
  end

end
