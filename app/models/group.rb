class Group < ActiveRecord::Base
  include Translatable
  include HasMemberships
  extend FriendlyId
  friendly_id :name, use: :slugged

  translates :description
  attr_accessible :name, :description, :slug
  attr_accessible :banner_image, :avatar_image
  attr_accessible :user_id

  validates :name, presence: true, uniqueness: true
  validates :user_id, presence: true

  belongs_to :user
  has_many :posts
  has_many :pages
  has_many :messages

  mount_uploader :banner_image, GroupBannerUploader
  mount_uploader :avatar_image, GroupAvatarUploader

  def site?
    false
  end

  def should_generate_new_friendly_id?
    new_record?
  end

end
