module UserInputCleaner
  extend ActiveSupport::Concern

  include ActionView::Helpers::SanitizeHelper

  module ClassMethods
    def clean_fields(*fields) 
      before_validation do
        fields.each do |field|
          clean_value = sanitize send("#{field}"), tags: %w(a p em strong), attributes: %(href)
          send("#{field}=", clean_value)
        end
      end
    end
  end
end