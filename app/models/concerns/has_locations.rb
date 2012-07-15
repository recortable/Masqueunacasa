module HasLocations
  extend ActiveSupport::Concern

  included do
    has_many :locations, as: :resource, dependent: :destroy
  end

end