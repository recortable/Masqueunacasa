module HasTranslatedSlugs
  extend ActiveSupport::Concern

  included do
    ## Crea slugs para todos los locales
    before_save do
      value = slug
      I18n.available_locales.each do |locale|
        send("slug_#{locale}=", value) if send("slug_#{locale}").blank?
      end
    end

    define_method "slug" do
      send("slug_#{I18n.locale}") || send("slug_#{I18n.default_locale}")
    end

    ## Add an additional module to friendly_id
    # that overrides find_one method on FrindlyId::History::FinderMethods
    friendly_id do |config|
      config.use :friendly_finder
    end
  end

end

