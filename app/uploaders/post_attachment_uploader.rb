# encoding: utf-8

require 'carrierwave/processing/mime_types'

class PostAttachmentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes

  storage :fog
  process :set_content_type

  # Example: "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  def store_dir
    "blog/#{model.group_id}"
  end


  def filename
    ext = File.extname(original_filename)
    "#{model.title}#{ext}"
  end
end
