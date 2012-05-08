class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  attr_accessible :group_id, :user_id, :state
  attr_accessible :group, :user

  STATES = ['owner', 'member', 'request', 'follow']

  validates :group_id, presence: true
  validates :user_id, presence: true
  validates :state, presence: true

  before_save :set_default_state

  private
  def set_default_state
    self.state ||= 'member'
  end
end
