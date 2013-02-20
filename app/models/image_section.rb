class ImageSection < Section
  attr_accessible :title, :image, :image_cache, :position

  mount_uploader :image, ImageUploader

  validates :image, presence: true
  default_scope where('1 = 2')
end
