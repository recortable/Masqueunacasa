class Ogroup < ActiveRecord::Base
  set_table_name :groups

  include ReceiveMessages
  include Translatable
  include HasMemberships
  translates :description

  attr_accessible :name, :description, :slug
  attr_accessible :banner_image, :avatar_image
  attr_accessible :user_id
  attr_accessible :subdomain, :domain
  attr_accessible :closed, :root
  attr_accessible :longitude, :latitude

  validates :user_id, presence: true

  belongs_to :user
  has_many :posts
  has_many :pages
  has_many :messages
  has_many :announcements

  default_scope order: 'updated_at ASC'
  scope :community, where(root: false)

  mount_uploader :banner_image, GroupBannerUploader
  mount_uploader :avatar_image, GroupAvatarUploader

  def self.root
    Group.where(root: true).first
  end

  def site?
    false
  end

  def recipients(scope = 'all')
    if scope == 'all'
      users
    elsif scope == 'members'
      users.select {|u| member_level?(u, [:member, :owner]) }
    elsif scope == 'admin'
      self.users.select {|u| member_level?(u, :owner) }
    else
      []
    end
  end

end
