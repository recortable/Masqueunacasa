module HasTranslations
  extend ActiveSupport::Concern
  include RecordLocaleFallback

  included do
    before_create :set_original_locale
  end

  def translated_to?(locale)
    translations.with_locale(locale).present?
  end

  protected

  def set_original_locale
    self.original_locale = I18n.locale if respond_to?(:original_locale)
  end
end
