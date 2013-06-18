module HasLocation
  extend ActiveSupport::Concern

  included do
    has_one :location, as: :resource, dependent: :destroy
  end

end