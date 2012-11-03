class NoticeImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  storage :fog

  process resize_to_fill: [570, 320]

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def store_dir
    "destacados/"
  end

  def public_id
    return "#{model.title.parameterize}"
  end
end
