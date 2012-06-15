class PostImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  process resize_to_limit: [600, 1000]

  version :mini do
    process resize_to_limit: [60, 100]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def store_dir
    "images/"
  end

  def public_id
    return "post_#{model.id}"
  end
end
