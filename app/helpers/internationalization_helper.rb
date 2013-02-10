module InternationalizationHelper
  def i14e(object)
    object.translated_to?(T.l) ? yield : T.w_l(object.original_locale) { yield }
  end
end
