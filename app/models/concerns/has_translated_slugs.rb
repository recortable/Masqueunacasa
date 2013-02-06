module HasTranslatedSlugs
  extend ActiveSupport::Concern

  included do
    before_create do
      value = slug
      I18n.available_locales.each do |locale|
        send("slug_#{locale}=", value) if send("slug_#{locale}").blank?
      end
    end
  end

  def slug
    send("slug_#{I18n.locale}")
  end
end
