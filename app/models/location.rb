# Represents a phisical location in a map
class Location < ActiveRecord::Base
  attr_accessible :resource_id, :resource_type, :user_id
  attr_accessible :title, :latitude, :longitude

  belongs_to :user
  belongs_to :resource, polymorphic: true
end
