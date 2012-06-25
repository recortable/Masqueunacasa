class Agent < ActiveRecord::Base
  # ATTRIBUTES
  attr_accessible :as_agent_id, :as_agent_type
  attr_accessible :name

  validates :name, presence: true, uniqueness: true,
            length: {minimum: 4, maximum: 50}

  # EXTENSIONS
  extend FriendlyId
  friendly_id :name, use: :slugged
  acts_as_superclass

end
