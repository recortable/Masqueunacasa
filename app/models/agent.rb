class Agent < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  attr_accessible :name, :description

  validates :name, presence: true, uniqueness: true
end
