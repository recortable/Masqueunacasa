module HasSections
  extend ActiveSupport::Concern

  included do
    attr_accessible :sections_attributes
    has_many :sections, as: :document, dependent: :destroy, 
      conditions: proc { ['lang = ?', I18n.locale] }
    accepts_nested_attributes_for :sections, allow_destroy: true
  end

  def add_section(section, user)
    section.document = self
    section.lang = I18n.locale
    section.body_type ||= 'markdown'
    if section.save
      self.add_editor(user) if section.document.respond_to?(:add_editor)
      section
    else
      nil
    end
  end
end
