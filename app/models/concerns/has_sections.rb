module HasSections
  extend ActiveSupport::Concern

  included do
    attr_accessible :text_sections_attributes
    attr_accessible :image_sections_attributes
    has_many :sections, as: :document, dependent: :destroy,
      conditions: proc { ['locale = ?', I18n.locale] }
    has_many :text_sections, as: :document,
      conditions: proc { ['locale = ?', I18n.locale] }
    has_many :image_sections, as: :document,
      conditions: proc { ['locale = ?', I18n.locale] }
    accepts_nested_attributes_for :text_sections, allow_destroy: true
    accepts_nested_attributes_for :image_sections, allow_destroy: true
  end
end
