module HasLocation
  extend ActiveSupport::Concern

  included do
    attr_accessible :location_attributes

    has_one :location, as: :resource, dependent: :destroy

    accepts_nested_attributes_for :location, allow_destroy: true,
      reject_if: proc { |attributes| attributes['address'].blank? }
  end

end

