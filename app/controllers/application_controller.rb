# encoding: utf-8
class ApplicationController < ActionController::Base
  include CurrentUser
  include HasCurrentGroup
  include ExposeResource
  include HasBreadcrumbs
  protect_from_forgery

  before_filter :set_locale
  before_filter :set_locale_from_url

  expose(:themes) { 'textura02 rojo' }
  expose(:site) { Site.new }

  expose(:with_banner) { false }

  # TODO: no se por qué falla en test (sospecho que algo
  # de los dominios, subdominios y la sesión)
  unless Rails.env.test?
    def info_for_paper_trail
      { user_name: (current_user.present? ? current_user.name : nil) }
    end
  end

  # Sobreescribimos el current_ability https://github.com/ryanb/cancan/wiki/Changing-Defaults
  def current_ability
    @current_ability ||= Ability.new(current_user, current_group)
  end

  def path_or_default(path)
    path.present? ? path : root_path
  end

  def set_locale
    locale = params[:locale] || ((lang = request.env['HTTP_ACCEPT_LANGUAGE']) && lang[/^[a-z]{2}/])
    locale = 'es' unless ['es', 'ca'].include? locale
    I18n.locale = locale
  end

  def require_root_domain
    redirect_to url_for(subdomain: false) if request.subdomain.present?
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: 'No puedes entrar ahí...'
  end

end
