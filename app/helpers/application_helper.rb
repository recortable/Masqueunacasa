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

  def render_card(&block)
    content = block_given? ? capture(&block) : ''
    render partial: 'application/card', locals: {content: content}
  end

  def avatar_image(model, options = {})
    options.reverse_merge! class: 'responsive'

    if model.avatar_image? 
      image_tag(model.avatar_image_url, alt: model.name, class: options[:class])
    else
      placeholder_image_tag(text: 'A', width: 140, height: 140, class: options[:class])
    end
  end
end
