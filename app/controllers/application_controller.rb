class ApplicationController < ActionController::Base
  include SubdomainGroups
  protect_from_forgery
  
  before_filter :set_locale
  before_filter :set_locale_from_url

  private

  def set_locale
    locale = params[:locale] || ((lang = request.env['HTTP_ACCEPT_LANGUAGE']) && lang[/^[a-z]{2}/])
    locale = 'es' unless ['es', 'ca'].include? locale
    I18n.locale = locale
  end
end
