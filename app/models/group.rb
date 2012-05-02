class Group < ActiveRecord::Base
  include Translatable
  extend FriendlyId
  friendly_id :name, use: :slugged

  translates :description
  attr_accessible :name, :description
  attr_accessible :slug
  attr_accessible :user_id

  validates :name, presence: true, uniqueness: true
  validates :user_id, presence: true

  belongs_to :user
  has_many :posts
  has_many :memberships
  has_many :users, through: :memberships

  after_create :create_owner_membership

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
