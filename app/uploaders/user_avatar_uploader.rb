class UserAvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  process resize_to_fill: [140, 140]

  version :mini do
    process resize_to_fill: [40, 40]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def store_dir
    "avatars/"
  end

  def public_id
    return "user_avatar_#{model.id}"
  end
end
