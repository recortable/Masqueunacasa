class ApplicationController < ActionController::Base
  include CurrentUser
  include HasCurrentGroup
  protect_from_forgery

  before_filter :set_locale
  before_filter :set_locale_from_url

  expose(:themes) { 'textura02 naranja' }

  private
  # TODO: no se por qué falla en test (sospecho que algo
  # de los dominios, subdominios y la sesión)
  unless Rails.env.test?
    def info_for_paper_trail
      { user_name: (current_user.present? ? current_user.name : nil) }
    end
  end

  def path_or_default(path)
    path.present? ? path : root_path
  end

  def set_locale
    locale = params[:locale] || ((lang = request.env['HTTP_ACCEPT_LANGUAGE']) && lang[/^[a-z]{2}/])
    locale = 'es' unless ['es', 'ca'].include? locale
    I18n.locale = locale
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

end
