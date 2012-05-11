
class Post < Content
  ARCHIVE_COLUMNS = column_names - ['body_en', 'body_ca', 'body_es', 'comments_count', 'embed', 'image', 'created_at', 'updated_at']

  mount_uploader :image, PostImageUploader
end
