module CategoryHelper
  def render_category_list(phase, options = {})
    options.reverse_merge! title: 'Preguntas'
    render partial: 'categories/list', 
      locals: { phase: phase, options: options }
  end

  def category_image(category)
    if category.image.present?
      image_tag(category.image_url, alt: category.question)
    else
      fake_image(800, 460)
    end
  end
end
