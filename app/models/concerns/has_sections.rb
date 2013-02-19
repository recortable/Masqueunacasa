module HasSections
  extend ActiveSupport::Concern

  included do
    attr_accessible :text_sections_attributes
    attr_accessible :image_sections_attributes
    has_many :sections, as: :document, dependent: :destroy
    has_many :text_sections, as: :document
    has_many :image_sections, as: :document
    accepts_nested_attributes_for :text_sections, allow_destroy: true,
      reject_if: proc { |attributes| attributes['title'].blank? && attributes['body'].blank? }
    accepts_nested_attributes_for :image_sections, allow_destroy: true,
      reject_if: proc { |attributes| attributes['title'].blank? && attributes['image'].blank? &&
                        attributes['image_cache'].blank? }
  end
end
