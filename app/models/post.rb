
class Post < Content

  has_many :attachments, class_name: 'PostAttachment'
  default_scope order: 'published_at DESC'

  attr_accessible :remove_image
  mount_uploader :image, PostImageUploader

  ARCHIVE_COLUMNS = column_names - ['body_en', 'body_ca', 'body_es', 'comments_count', 'embed', 'image', 'created_at', 'updated_at']

  def self.archive_for(posts) 
    posts.select(Post::ARCHIVE_COLUMNS).group_by { |post| post.published_at.beginning_of_month }
  end

end
