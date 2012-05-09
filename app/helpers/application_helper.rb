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

  # Translate collection
  # Used in forms (see views/memberships/edit)
  def tc(prefix, collection)
    collection.map {|item| [I18n.t("#{prefix}.#{item}"), item] }
  end

  def render_banner(title, path)
    render partial: 'application/banner', locals: 
      {title: title, path: path}
  end

  def avatar_image(model)
    model.avatar_image? ? image_tag(model.avatar_image_url, alt: model.name, class: 'responsive') :
      placeholder_image_tag(text: '', width: 140, height: 140, class: 'responsive')
  end
end
