module ImageHelper
  def fake_img(width, height, options = {}) 
    options.reverse_merge! class: 'responsive'

    extra = options[:text].present? ? "/#{options[:text]}" : ''
    raw("<img src='http://cambelt.co/#{width}x#{height}#{extra}' class='#{options[:class]}' />")
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
