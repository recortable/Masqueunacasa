module LayoutHelper
  def corner_span(css_class, color = :colored, &block)
    content = capture(&block)
    raw "<div class='#{css_class}'><div class='corner #{color}'></div><div class='content'>#{content}</div></div>"
  end

  def submit_button(form, text = 'Enviar', color = 'negro')
    raw "<div class='submit-wrapper #{color}'>
           #{form.button :submit, value: text}
           <div class='side-right'></div>
         </div>"
  end

  def link_box(text, url, css_class = '')
    raw "<div class='link-wrapper clearfix #{css_class}'>
           #{ link_to text, url }
           <div class='side right-side'></div>
         </div>"
  end
end
