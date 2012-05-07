class PostImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process tags: ['post']

  version :thumb do
    process :resize_to_fit => [360,100]
  end

  def public_id
    return "post_#{model.id}"
  end
end
