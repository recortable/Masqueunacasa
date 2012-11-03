module CategoryHelper
  def category_image(category)
    if category.image.present?
      image_tag(category.image_url, alt: category.title)
    else
      fake_img(800, 460)
    end
  end
end
