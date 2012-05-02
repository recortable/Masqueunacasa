class Group < ActiveRecord::Base
  include Translatable
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
  has_many :memberships
  has_many :users, through: :memberships

  mount_uploader :banner_image, GroupBannerUploader
  mount_uploader :avatar_image, GroupAvatarUploader

  after_create :create_owner_membership

  def site?
    false
  end

  def should_generate_new_friendly_id?
    new_record?
  end

  def add_member(user)
    Membership.create!(group: self, user: user, state: 'member')
  end

  private
  def create_owner_membership
    Membership.create!(group: self, user: self.user, state: 'owner')
  end
end
