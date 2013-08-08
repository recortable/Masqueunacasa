class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  attr_accessible :name, :email, :summary, :admin
  attr_accessible :login_count, :last_login_at
  attr_accessible :password, :password_confirmation
  attr_accessible :avatar_image

  validates :email, presence: true,
    uniqueness: true,
    length: {minimum: 5, maximum: 60},
    format: {with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  validates :password, presence: true, on: :create,
    length: {minimum: 3, maximum: 60},
    confirmation: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :summary, length: { maximum: 500 }

  # RELATIONS
  has_many :editorships
  has_many :memberships, dependent: :destroy
  include HasLocation

  # EXTENSIONS
  has_secure_password
  mount_uploader :avatar_image, UserAvatarUploader

  def title
    name
  end

  def self.current_user
    Thread.current[:current_user]
  end

  def self.current_user=(user)
    Thread.current[:current_user] = user
  end

  def build_reset_password_token
    begin
      self.reset_password_token = SecureRandom.urlsafe_base64
    end while User.exists?(reset_password_token: self[:reset_password_token])
  end
end
