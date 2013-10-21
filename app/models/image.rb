class Image < ActiveRecord::Base
  attr_accessible :title,
                  :image,
                  :image_cache,
                  :external_image_url,
                  :credits,
                  :new_object
  delegate :title, to: :imageable, prefix: true

  default_scope order: 'position ASC'
  belongs_to :user
  belongs_to :imageable, polymorphic: true

  acts_as_list scope: [:imageable_type, :imageable_id]
  mount_uploader :image, ImageUploader

  def new_object
    new_record?
  end

  def new_object=(value)
    nil
  end
end
