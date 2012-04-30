# Translatable
#
# Permite la traducción de columnas en la base de datos
#
module Translatable
  extend ActiveSupport::Concern

  module ClassMethods
    def translates(*columns)
      columns.each do |column|
        define_method "#{column}" do
          result = self.send("#{column}_#{I18n.locale}")
          if result.blank?
            self.send("#{column}_#{I18n.default_locale}")
          else
            result
          end
        end

        define_method "#{column}=" do |value|
          self.send("#{column}_#{I18n.locale}=", value)
        end
      end
    end
  end
end
