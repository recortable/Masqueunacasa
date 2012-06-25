class Ouser < ActiveRecord::Base
  set_table_name :users

  # EXTENSIONS
  include ReceiveMessages
  include ResetPasswordToken
  include HasSections
  include HasPopularity

  has_secure_password
  mount_uploader :avatar_image, UserAvatarUploader

  # RELATIONS
  has_many :posts
  has_many :created_groups, class_name: 'Group', foreign_key: 'user_id'
  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships


  # ATTRIBUTES
  attr_accessible :name, :description, :avatar_image
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :admin


  # VALIDATIONS
  validates :email, presence: true,
            uniqueness: true,
            length: {minimum: 5, maximum: 60},
            format: {with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  validates :password, presence: true, on: :create,
            length: {minimum: 3, maximum: 60},
            confirmation: true

  def member?(group)
    Membership.where(group_id: group.id, user_id: self.id).first.present?
  end

end
