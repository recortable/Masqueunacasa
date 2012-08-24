class Group < Agent
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_paper_trail meta: {title: :title, group_id: :id, item_type: 'Group' }

  attr_accessible :user_id, :memberships_count, :banner_image
  attr_accessible :has_blog, :has_pages, :has_announcements

  store :settings, accessors: [:has_blog, :has_pages, :has_announcements, :last_mail_at, :last_mailer_try_at]

  [:has_blog, :has_pages, :has_announcements].each do |name|
    define_method "#{name}?" do
      self.send(name) == '1'
    end
  end


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

  def subdomain
    admin? ? false : slug
  end

  def recipients
    users
  end
end
