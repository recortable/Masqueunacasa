
class Post < Content

  has_many :attachments, class_name: 'PostAttachment'
  default_scope order: 'published_at DESC'

  attr_accessible :remove_image
  mount_uploader :image, PostImageUploader
end
