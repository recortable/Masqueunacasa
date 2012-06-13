class Group < ActiveRecord::Base
  include ReceiveMessages
  include Translatable
  include HasMemberships
  extend FriendlyId
  friendly_id :name, use: :slugged

  translates :description
  attr_accessible :name, :description, :slug
  attr_accessible :banner_image, :avatar_image
  attr_accessible :user_id
  attr_accessible :subdomain, :domain
  attr_accessible :closed
  attr_accessible :longitude, :latitude

  validates :name, presence: true, uniqueness: true
  validates :user_id, presence: true

  belongs_to :user
  has_many :posts
  has_many :pages
  has_many :messages
  has_many :announcements

  mount_uploader :banner_image, GroupBannerUploader
  mount_uploader :avatar_image, GroupAvatarUploader

  def self.main
    Group.reorder('id ASC').first
  end

  def site?
    false
  end

  def recipients(scope = 'all')
    recipients = []
    if scope == 'all'
      return self.users.map
    elsif scope == 'members'
      self.users.each do |user|
        if self.member_level?(user, "member") | self.member_level?(user, "owner")
          recipients << user
        end
      end
    elsif scope == 'admin'
      self.users.each do |user|
        if self.member_level?(user, "owner")
          recipients << user
        end
      end
    end

    recipients
  end
end
