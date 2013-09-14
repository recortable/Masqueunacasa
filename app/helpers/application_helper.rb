module ApplicationHelper
  def title(title, tag = :h1)
    content_for(:title) { title }
    content_tag(tag, title)
  end

  def front_path
    root_url + T.l.to_s
  end

  def controller_class
    controller.class.name[0..-11].downcase.gsub(/:/, '-') + " " + controller.action_name
  end

  def current_user_admin?
    current_user && current_user.admin?
  end

  def hover?(action, subject, &block)
    if can? action, subject
      content_tag(:div, capture(&block), class: 'hover')
    else
      ''
    end
  end

  def simple_list(collection, options = {}, &block)
    options.reverse_merge! class: ''
    content = "<table class='table #{options[:class]}'>"
    collection.each do |item|
      content += "<tr><td>#{capture(item, &block)}</td></tr>"
    end
    content += '</table>'
    raw content
  end

  def icon(icon, label = nil)
    label = label.present? ? h(" #{label}") : ''
    raw("<i class='icon-#{icon}'></i>#{label}")
  end

  def icon_after(icon, label = nil)
    label = label.present? ? h("#{label} ") : ''
    raw("#{label} <i class='icon-#{icon}'></i>")
  end

  def front?
    controller.controller_name == "dashboard" && controller.action_name == "welcome"
  end

  def intern_link_code?
    %w{index show}.include?(controller.action_name) && current_user
  end

  def link_code
    code = "[#{t('application.internal_link_code.link_text')}]"
    code += "(::" + controller.controller_name
    code += "::" + object_identifier.to_s if object_identifier
    code += "::)"
  end

private

  def object_identifier
    params[:id].present? ?
      controller.controller_name.classify.constantize.find(params[:id]).id :
      nil
  end
end
