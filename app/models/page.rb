class Page < Content
  mount_uploader :image, PageImageUploader
  has_paper_trail
end
