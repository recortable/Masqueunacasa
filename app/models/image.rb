class Image < ActiveRecord::Base
  belongs_to :user
  belongs_to :imageable, polymorphic: true
  delegate :title, to: :imageable, prefix: true
  default_scope order: 'position ASC'

  attr_accessible :title, :image
  validates :title, presence: true
  #validates :image, presence: true

  acts_as_list scope: [:imageable_type, :imageable_id]
  mount_uploader :image, ImageUploader
  has_paper_trail meta: { title: :title, parent_title: :imageable_title, document: :imageable }

end
