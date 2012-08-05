# encoding: utf-8

class CategoryImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :fog

  def store_dir
    "preguntas/"
  end

  def filename
    model.slug_es
  end

  # Process files as they are uploaded:
  process resize_to_limit: [800, 800]

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
