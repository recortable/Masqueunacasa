module RecordTranslator
  extend ActiveSupport::Concern

  included do
    class_eval do
      def globalize_fallbacks(locale)
        if record_fallback?(locale)
          [locale, original_locale]
        else
          Globalize.fallbacks(locale)
        end
      end

      def record_fallback?(locale)
        respond_to?("original_locale") and
          original_locale.present? and
          original_locale != locale
      end
    end
  end
end

