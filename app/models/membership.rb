class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  attr_accessible :group_id, :user_id
  attr_accessible :group, :user

  validates :group_id, presence: true
  validates :user_id, presence: true
end
