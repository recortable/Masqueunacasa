module T
  extend self
  
  def self.l
    return I18n.locale
  end

  def self.l=(locale)
    I18n.locale = locale
  end

  def self.avl
    return I18n.available_locales
  end

  def self.w_l(locale)
    I18n.with_locale(locale) { yield }
  end
end