# Represents a phisical location in a map
class Location < ActiveRecord::Base
  attr_accessible :resource_id, :resource_type, :user_id
  attr_accessible :address


  belongs_to :user
  belongs_to :resource, polymorphic: true

  acts_as_gmappable process_geocoding: :geocode?, address: 'address',
                    normalized_address: 'normalized_address',
                    callback: :save_address_components

  scope :of_experiencies, where(resource_type: 'Expeiencie')

  def geocode?
    (address.present? && (latitude.blank? || longitude.blank? )) || address_changed?
  end

  def save_address_components(data)
    data["address_components"].each do |c|
      if c["types"].include? 'country'
        self.country = c["long_name"]
      end
      if c['types'].include? 'administrative_area_level_1'
        self.region = c['long_name']
      end
      if c["types"].include? 'locality'
        self.locality = c['long_name']
      end
    end
  end
end
