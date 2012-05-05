module LayoutHelper
  def corner_span(css_class, color = :colored, &block)
    content = capture(&block)
    raw "<div class='#{css_class}'><div class='corner #{color}'></div><div class='content'>#{content}</div></div>"
  end

  def submit_button_for(form, text = nil, color = 'negro')
    options = text ? {value: text} : {}
    raw "<div class='submit-wrapper #{color}'>
    #{form.button :submit, options}
           <div class='side-right'></div>
         </div>"
  end

  def link_box(text, url, opt = {})
    opt.reverse_merge!({show_if_current: true})
    unless current_page?(url) && !opt[:show_if_current]
      raw "<div class='link-wrapper clearfix #{opt[:class]}'>
      #{ link_to text, url, opt.slice(:method, :confirm) }
           <div class='side right-side'></div>
         </div>"
    end
  end
end
