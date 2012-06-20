module ApplicationHelper
  def title(title, tag = :h1)
    content_for(:title) { title }
    content_tag(tag, title)
  end

  def controller_class
    controller.class.name[0..-11].downcase.gsub(/:/, '-')
  end

  def subdomain_class
    request.subdomain.present? ? 'subdomain' : 'main_domain'
  end

  def current_user_admin?
    current_user && current_user.admin?
  end

  # Translate collection
  # Used in forms (see views/memberships/edit)
  def tc(prefix, collection)
    collection.map {|item| [I18n.t("#{prefix}.#{item}"), item] }
  end

  def render_banner(title, path)
    render partial: 'application/banner', locals: 
      {title: title, path: path}
  end

  def render_card(&block)
    content = block_given? ? capture(&block) : ''
    render partial: 'application/card', locals: {content: content}
  end

  def hover?(action, subject, &block)
    if can? action, subject
      content_tag(:div, capture(&block), class: 'hover')
    else
      ''
    end
  end

  def simple_list(collection, &block)
    content = '<table class="table">'
    collection.each do |item|
      content += "<tr><td>#{capture(item, &block)}</td></tr>"
    end
    content += '</table>'
    raw content
  end
end
