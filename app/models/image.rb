class Image < ActiveRecord::Base
  belongs_to :user
  belongs_to :imageable, polymorphic: true

  attr_accessible :title, :image

  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :image, presence: true
end