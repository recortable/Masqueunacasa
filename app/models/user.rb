class User < Agent
  # RELATIONS
  has_many :posts
  #has_many :memberships, dependent: :destroy

  # EXTENSIONS
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_secure_password

  # ATTRIBUTES
  attr_accessible :email, :password, :password_confirmation, :remember_me

  # VALIDATIONS
  validates :name, presence: true,
            length: {minimum: 3, maximum: 50}
  validates :email, presence: true,
            uniqueness: true,
            length: {minimum: 5, maximum: 60},
            format: {with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  validates :password, presence: true, on: :create,
            length: {minimum: 3, maximum: 60},
            confirmation: true
end
