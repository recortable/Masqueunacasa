
class Post < Content

  # TODO: ¿Pau, para qué es esto?
  ARCHIVE_COLUMNS = column_names - ['body_en', 'body_ca', 'body_es', 'comments_count', 'embed', 'image', 'created_at', 'updated_at']

  has_many :attachments, class_name: 'PostAttachment'

  mount_uploader :image, PostImageUploader

end
