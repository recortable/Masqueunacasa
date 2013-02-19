class ImageSection < Section
  attr_accessible :title, :image, :image_cache, :position

  mount_uploader :image, ImageUploader

  validates :image, presence: true
  default_scope lambda { where(locale: T.l.to_s, id: nil).order('position ASC') }
end
