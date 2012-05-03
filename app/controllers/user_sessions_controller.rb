# encoding: utf-8
class UserSessionsController < ApplicationController
  expose(:user_session)
  expose(:user) { User.new }
  expose(:themes) { 'textura04 azul_gris' }

  def new
    authorize! :new, user_session
  end

  def create
    if user_session.create
      login_user(user_session.user)
      redirect_to root_path, notice: 'Bienvenidx'
    else
      flash.now.notice = "Los datos no corresponden con nadie."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Adiós"
    redirect_to root_path
  end
  
  # Este método es una puerta de entrada que no está disponible en
  # producción. Se usa en los tests y en desarrollo.
  def enter
    self.current_user = User.find params[:id]
    flash[:notice] = "Hola #{current_user.name}"
    redirect_to root_path
  end

end
