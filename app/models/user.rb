class User < Agent
  extend FriendlyId
  friendly_id :name, use: :slugged

  attr_accessible :login_count, :last_login_at
  store :settings, accessors: [:reset_password_sent_at]

  validates :email, presence: true,
    uniqueness: true,
    length: {minimum: 5, maximum: 60},
    format: {with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  validates :password, presence: true, on: :create,
    length: {minimum: 3, maximum: 60},
    confirmation: true

  # RELATIONS
  has_many :posts
  has_many :created_groups, class_name: 'Group', foreign_key: 'user_id'
  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships

  # EXTENSIONS
  has_secure_password
  mount_uploader :avatar_image, UserAvatarUploader

  def member?(group)
    Membership.where(group_id: group.id, user_id: self.id).first.present?
  end

end
