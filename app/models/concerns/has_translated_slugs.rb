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

module FriendlyId
  module History

    # Adds a finder that explictly uses slugs from the slug table.
    module FinderMethods
      # Search for a record in the slugs table using the specified slug.
      def find_one(id)
        return super(id) if id.unfriendly_id?
        where("slug_es = ? OR slug_ca = ? OR slug_en = ?", id, id, id).first or
        with_old_friendly_id(id) {|x| find_one_without_friendly_id(x)} or
        find_one_without_friendly_id(id)
      end
    end
  end
end

