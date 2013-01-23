module LayoutHelper

  def main_content_span_size
    size = 12
    size = size - 2 if content_for?(:left)
    size = size - 4 if content_for?(:right)
    size
  end

  # TODO: deprecated, use page_div
  def page(options = {}, &block)
    options.reverse_merge! class: '', row: true, head: true
    page_div(options, &block)
  end

  def header
    header_content = group_name
    header_content += group_banner if print_banner?
    header_content.html_safe
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

  private

    def group_name
      result = "<div class='group_name'>"
      if !current_group or current_group.admin?
        result += image_tag 'Logo_Mquc.png', width: 271, height: 41, class: 'mquc', alt: "Masqueunacasa"
      else
        result += current_group.name
      end
      result += "</div>"
    end

    def group_banner
      if current_group.banner_image?
        image_tag(current_group.banner_image_url, class: 'responsive', alt: current_group.name)
      else
        placeholder_image_tag({text: '1170x200px', width: 1170, height: 200}, {class: 'responsive'})
      end
    end

    def print_banner?
      current_group and
      with_banner
    end
end
