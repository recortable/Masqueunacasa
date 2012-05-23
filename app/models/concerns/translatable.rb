# Translatable
#
# Permite la traducción de columnas en la base de datos
#
module Translatable
  extend ActiveSupport::Concern

  # Copia el valor de la columna a las traducciones que no tienen nada
  def propagate_translation(column)
    value = send(column)
    [:es, :ca].each do |locale|
      send("#{column}_#{locale}=", value) unless send("#{column}_#{locale}?")
    end
  end

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

    def translation_required(*columns) 
      before_validation do
        columns.each {|col| propagate_translation(col) }
      end
    end
  end
end
