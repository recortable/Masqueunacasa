class Group < Agent
  extend FriendlyId
  friendly_id :name, use: :slugged

  attr_accessible :subdomain, :user_id, :memberships_count, :banner_image
  store :settings, accessors: [:closed]

  #validates :user_id, presence: true

  default_scope order: 'updated_at ASC'
  scope :community, where(admin: false)

  belongs_to :user
  has_many :posts
  has_many :pages
  has_many :messages
  has_many :announcements
  include HasMemberships

  mount_uploader :banner_image, GroupBannerUploader
  mount_uploader :avatar_image, GroupAvatarUploader
  include ReceiveMessages

  def self.root
    Group.where(admin: true).first
  end

  def site?
    false
  end

  def closed?
    closed
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
