module ImageHelper
  def fake_img(width, height, options = {}) 
    options.reverse_merge! class: 'responsive', text: ''
    text = options.delete(:text)
    placeholder_image_tag({width: width, height: height, 
                           text: text}, options)
  end

  def fake_img_fixed(width, height, options = {})
    options.reverse_merge! class: 'fixed'
    fake_img(width, height, options)
  end

  def quick_avatar(name)
    image_tag "http://archivos.masqueunacasa.org/avatars/mini_#{name.parameterize}.png", 
      alt: name, width: 44, height: 44, class: 'avatar'
  end

  def avatar_image(model, options = {})
    options.reverse_merge! class: 'responsive', size: 'normal'

    size = options[:size] == :small ? 44 : 140
    css_class = "avatar #{options[:class]}"

    if model.avatar_image? 
      url = options[:size] == :small ? model.avatar_image_url(:mini) : model.avatar_image_url
      image_tag(url, alt: model.title, class: css_class, width: size, height: size)
    else
      image_tag('comm/user.png', width: size, height: size, class: css_class, alt: model.title)
    end
  end

  def avatar_link(model, options = {})
    link_to avatar_image(model, options), model
  end

  def icon_type(document, options = {})
    options.reverse_merge! size: 150
    if document.class == Proposal
      image_tag('habitap/proposal.png', alt: document.title, width: options[:size], height: options[:size])
    else
      fake_img(options[:size], options[:size], text: document.title)
    end
  end

end
