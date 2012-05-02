class ApplicationController < ActionController::Base
  include CurrentUser
  include SubdomainGroups
  protect_from_forgery
  
  before_filter :set_locale
  before_filter :set_locale_from_url

  expose(:themes) { 'textura02 naranja' }

  private

  def set_locale
    locale = params[:locale] || ((lang = request.env['HTTP_ACCEPT_LANGUAGE']) && lang[/^[a-z]{2}/])
    locale = 'es' unless ['es', 'ca'].include? locale
    I18n.locale = locale
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, notice: 'No puedes hacer eso...'
  end
  
end
