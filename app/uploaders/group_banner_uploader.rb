class GroupBannerUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  process resize_to_fill: [1170, 200]

  version :mini do
    process resize_to_fill: [117, 20]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def store_dir
    "banners/"
  end

  def public_id
    return "group_banner_#{model.id}"
  end
end
