# encoding: utf-8
class ApplicationController < ActionController::Base
  include CurrentUser
  include ExposeResource
  include HasBreadcrumbs
  include HasResource
  protect_from_forgery

  before_filter :set_locale
  before_filter :set_locale_from_url
  include SlugRedirections ## Tiene que ir después de :set_locale_from_url

  expose(:themes) { 'textura02 rojo' }
  expose(:site) { Site.new }

  expose(:with_banner) { false }

  # Sobreescribimos el current_ability https://github.com/ryanb/cancan/wiki/Changing-Defaults
  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def path_or_default(path)
    path.present? ? path : root_path
  end

  def set_locale
    locale = params[:locale]
    unless locale.present? and I18n.available_locales.include?(locale.to_sym)
      location = request.fullpath
      locale = request.compatible_language_from(I18n.available_locales) || I18n.default_locale
      location = '/' + locale.to_s + location
      redirect_to location, status: :moved_permanently
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: 'No puedes entrar ahí...'
  end

  ## Al final de routes.rb hay una directiva que captura todas las urls y las 'mapea' al método set_locale.
  ## Esto es para mantener el soporte a antiguas rutas sin el prefijo de idioma, pero puede que se lance la
  ## excepción ActionView::MissingTemplate en aquellas rutas para las que no haya ningún controlador ni acción.
  rescue_from ActionView::MissingTemplate do |exception|
    controller_name == "application" ?
      raise(ActionController::RoutingError.new "No route matches '#{request.fullpath}'") :
      raise(exception)
  end
end
