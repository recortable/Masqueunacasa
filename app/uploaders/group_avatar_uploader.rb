class GroupAvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  
  process resize_to_fill: [140, 140, :north]

  process tags: ['group', 'avatar']

  version :medium do
    process :resize_to_fill => [40,40, :north]
  end

  def public_id
    return "group_avatar_#{model.id}"
  end
end
