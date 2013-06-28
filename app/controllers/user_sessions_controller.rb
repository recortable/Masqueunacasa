# encoding: utf-8
class UserSessionsController < ApplicationController
  respond_to :html
  expose(:user_session)
  expose(:user) { User.new }
  expose(:themes) { 'textura_inicio negro' }

  def new
    if request.subdomain.present?
      redirect_to login_url(host: request.domain)
    else
      authorize! :new, user_session
    end
  end

  def show

  end

  def create
    if user_session.create
      login_user(user_session.user)
      redirect_to path_or_default(params[:from]), notice: 'Bienvenidx'
    else
      flash.now[:error] = "Los datos no corresponden con nadie."
      render "new"
    end
  end

  def destroy
    if request.subdomain.present?
      redirect_to logout_url(host: request.domain)
    else
      session[:user_id] = nil
      flash[:notice] = "Adiós"
      path = params[:from].present? ? params[:from] : root_path
      redirect_to path
    end
  end

  # Este método es una puerta de entrada que no está disponible en
  # producción. Se usa en los tests y en desarrollo.
  def enter
    self.current_user = User.find params[:id]
    flash[:notice] = "Hola #{current_user.name}"
    redirect_to root_path
  end

end
