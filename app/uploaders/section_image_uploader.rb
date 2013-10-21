# encoding: utf-8

class SectionImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :fog

  def store_dir
    "sections/#{model.id}"
  end

  def public_id
    return "image_#{model.id}"
  end

  version :thumb do
    process resize_to_fit: [100, 100]
  end

  # Process files as they are uploaded:
  process resize_to_limit: [1200, 900]

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end

