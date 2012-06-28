# encoding: utf-8

require 'carrierwave/processing/mime_types'

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes
  include CarrierWave::MiniMagick

  storage :fog
  process :set_content_type
  process resize_to_fit: [600, 1000]
  process convert: 'jpg'

  version :mini do
    process resize_to_limit: [60, 100]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def store_dir
    "images/"
  end

  def filename
    "#{model.document.title.parameterize}-#{model.id}.jpg" if original_filename
  end
end
