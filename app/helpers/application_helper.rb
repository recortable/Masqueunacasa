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

  def avatar_image(model, options = {})
    options.reverse_merge! class: 'responsive', size: 'normal'

    size = options[:size] == :small ? 40 : 140

    if model.avatar_image? 
      url = options[:size] == :small ? model.avatar_image_url(:mini) : model.avatar_image_url
      image_tag(url, alt: model.name, class: options[:class], width: size, height: size)
    else
      placeholder_image_tag(text: 'A', width: size, height: size, class: options[:class])
    end
  end

end
