class Image < ActiveRecord::Base
  belongs_to :user
  belongs_to :imageable, polymorphic: true

  acts_as_list scope: [:imageable_type, :imageable_id]
  default_scope order: 'position ASC'

  attr_accessible :title, :image

  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :image, presence: true
end