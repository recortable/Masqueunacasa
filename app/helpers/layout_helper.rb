# encoding: utf-8
module LayoutHelper

  def main_content_span_size
    size = 12
    size = size - 2 if content_for?(:left)
    size = size - 4 if content_for?(:right)
    size
  end

  def corner_span(css_class, color = :colored, &block)
    content = capture(&block)
    raw "<div class='#{css_class}'><div class='corner #{color}'></div><div class='content'>#{content}</div></div>"
  end

  def user_column(css_class, color = :none, &block)
    content = capture(&block)
    raw "<div class='user-column #{css_class}'>#{content}</div>"
  end

  def submit_button_for(form, options = {})
    options.reverse_merge!(color: 'negro')
    color = options.delete(:color)
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

  def active?(tab_name)
    return 'active' if tab_name == @active_tab
  end
end
