# Represents a phisical location in a map
class Location < ActiveRecord::Base
  attr_accessible :resource_id, :resource_type, :user_id
  attr_accessible :latitude, :longitude


  belongs_to :user
  belongs_to :resource, polymorphic: true

  validates :latitude, presence: true
  validates :longitude, presence: true

  scope :of_experiencies, where(resource_type: 'Expeiencie')
end
