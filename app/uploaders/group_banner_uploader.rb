class GroupBannerUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process tags: ['group', 'banner']
  process resize_to_limit: [1170, 400]

  version :thumb do
    process :resize_to_fit => [360,100]
  end

  def public_id
    return "group_#{model.id}"
  end
end
