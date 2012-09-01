module LayoutHelper


  # TODO: deprecated, use page_div
  def page(options = {}, &block)
    options.reverse_merge! class: '', row: true, head: true
    page_div(options, &block)
  end

  # CUIDADO!: row es false por defecto (al revés que page)
  def page_div(options = {}, &block)
    options.reverse_merge! class: '', row: false, head: true, group: true
    content = capture(&block)
    content = "<div class='row'>#{content}</div>" if options[:row]
    head = options[:head] ? render('page_header', group: options[:group]) : ''
    corner = "<div class='corner none'></div>"
    raw "<div class='#{options[:class]}'>#{corner}</div><div class='page bloc'>#{head}#{content}</div>"
  end

  def corner_span(css_class, color = :colored, &block)
    content = capture(&block)
    raw "<div class='#{css_class}'><div class='corner #{color}'></div><div class='content'>#{content}</div></div>"
  end

  def user_column(css_class, color = :none, &block)
    content = capture(&block)
    raw "<div class='#{css_class}'><div class='user-column content-inner'>#{content}</div></div>"
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
end
