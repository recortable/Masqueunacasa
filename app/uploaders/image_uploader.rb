# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :fog

  def store_dir
    "images/#{model.imageable_type.underscore}_#{model.imageable_id}/#{model.id}"
  end

  def public_id
    return "image_#{model.id}"
  end

  # Process files as they are uploaded:
  process resize_to_limit: [1200, 900]

  version :small do
    process resize_to_fit: [300, 400]
  end

  version :thumb do
    process resize_to_fit: [100, 100]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end

