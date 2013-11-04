class ImageSection < Section
  attr_accessible :title, :image, :image_cache, :position

  mount_uploader :image, SectionImageUploader

  validates :image, presence: true
end

