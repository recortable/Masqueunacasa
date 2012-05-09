class UserAvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  
  process resize_to_fill: [140, 140, :north]

  process tags: ['user', 'avatar']

  version :medium do
    process :resize_to_fill => [40,40, :north]
  end

  def public_id
    return "user_avatar_#{model.id}"
  end
end
