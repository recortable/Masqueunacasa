class Page < Content
  mount_uploader :image, PageImageUploader
  has_paper_trail

  validates_presence_of :body_type
end
