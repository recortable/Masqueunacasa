class GroupAvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  
  process resize_to_fill: [120, 120, :north]

  process tags: ['group', 'avatar']

  version :medium do
    process :resize_to_fill => [40,40, :north]
  end

  def public_id
    return "post_avatar_#{model.id}"
  end
end
