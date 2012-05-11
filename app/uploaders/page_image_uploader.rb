class PageImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process tags: ['page']

  version :thumb do
    process :resize_to_fit => [360,100]
  end

  def public_id
    return "page#{model.id}"
  end
end
