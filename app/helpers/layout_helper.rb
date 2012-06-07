module LayoutHelper
  def corner_span(css_class, color = :colored, &block)
    content = capture(&block)
    raw "<div class='#{css_class}'><div class='corner #{color}'></div><div class='content'>#{content}</div></div>"
  end

  def tabs(&block)
    content = capture(&block)
    raw "<ul class='tabs clearfix'>#{content}</ul>"
  end

  def submit_button_for(form, text = nil, color = 'negro')
    options = text ? {value: text} : {}
    raw "<div class='submit-wrapper #{color}'>
    #{form.button :submit, options}
           <div class='side-right'></div>
         </div>"
  end

  def link_box(text, url, options = {})
    options.reverse_merge!({show_if_current: true})
    show_if_current = options.delete :show_if_current
    css_class = options.delete :class
    unless current_page?(url) && !show_if_current
      raw "<div class='link-wrapper clearfix #{css_class}'>
      #{link_to(text, url, options)}
           <div class='side right-side'></div>
         </div>"
    end
  end
end
