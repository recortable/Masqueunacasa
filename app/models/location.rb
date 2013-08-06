# Represents a phisical location in a map
class Location < ActiveRecord::Base
  attr_accessible :resource_id, :resource_type, :user_id
  attr_accessible :latitude, :longitude


  belongs_to :user
  belongs_to :resource, polymorphic: true

  validates :latitude, presence: true
  validates :longitude, presence: true

  acts_as_gmappable process_geocoding: :geocode?, address: 'address',
                    normalized_address: 'address'

  scope :of_experiencies, where(resource_type: 'Expeiencie')

  def geocode?
    (address.present? && (latitude.blank? || longitude.blank? )) || address_changed?
  end
end
