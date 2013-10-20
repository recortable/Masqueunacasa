class ImageSection < Section
  attr_accessible :title, :image, :image_cache, :position

  mount_uploader :image, ImageUploader

  validates :image, presence: true
end
