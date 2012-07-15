module HasSections
  extend ActiveSupport::Concern

  included do
    has_many :sections, as: :document, dependent: :destroy, conditions: proc { ['lang = ?', I18n.locale] }
  end

  def add_section(section, user)
    section.document = self
    section.lang = I18n.locale
    section.body_type ||= 'markdown'
    if section.save
      section
      self.add_editor(user)
    else
      nil
    end
  end
end
