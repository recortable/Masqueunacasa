module HasSections
  extend ActiveSupport::Concern

  included do
    has_many :sections, as: :document, conditions: proc { ['lang = ?', I18n.locale] }
  end
end
