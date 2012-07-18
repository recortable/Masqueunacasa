class Page < Content
  mount_uploader :image, PageImageUploader

  validates_presence_of :body_type
end
