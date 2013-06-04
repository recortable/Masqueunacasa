# encoding: utf-8
class UserSessionsController < ApplicationController
  respond_to :html
  expose(:user_session)
  expose(:user) { User.new }
  expose(:themes) { 'textura_inicio negro' }

  def new
    if current_user
      redirect_to path_or_default(request.env['HTTP_REFERER']),
        notice: t('user_sessions.notices.already_logged_in')
    else
      render 'new', layout: nil
    end
  end

  def show

  end

  def create
    if user_session.create
      login_user(user_session.user)
      redirect_to path_or_default(params[:from]),
        notice: t('user_sessions.notices.created', user: user_session.user.name)
    else
      flash.now[:error] = t('user_sessions.notices.error')
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = t('user_sessions.notices.destroyed')
    path = params[:from].present? ? params[:from] : root_path
    redirect_to path
  end

  # Este método es una puerta de entrada que no está disponible en
  # producción. Se usa en los tests y en desarrollo.
  def enter
    self.current_user = User.find params[:id]
    flash[:notice] = "Hola #{current_user.name}"
    redirect_to root_path
  end

end
