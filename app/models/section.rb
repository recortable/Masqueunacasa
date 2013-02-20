require 'file_size_validator'

class Section < ActiveRecord::Base
  attr_accessible :group_id
  attr_accessible :document_id, :document_type
  attr_accessible :locale
  delegate :title, to: :document, prefix: true

  before_validation :populate_fields

  belongs_to :document, polymorphic: true, touch: true

  default_scope lambda { where(locale: T.l.to_s).order('position ASC') }

  scope :titled, where("title <> ''")

  acts_as_list scope: [:document_type, :document_id, :locale]
  include DocumentHasEditors

  def to_anchor
    title.present? ? title : position.to_s
  end

  def self.with_locale_fallback_for(document)
    if !document.respond_to?('original_locale') or document.translated_to?(T.l)
      document.sections
    else
      Section.unscoped.where(document_id: document.id,
                             document_type: document.class.to_s,
                             locale: document.original_locale).
        order('position ASC')
    end
  end

  protected

  def populate_fields
    self.locale ||= I18n.locale
  end
end
