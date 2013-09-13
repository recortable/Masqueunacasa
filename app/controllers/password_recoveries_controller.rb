# encoding: utf-8
class PasswordRecoveriesController < ApplicationController
  expose(:themes) { 'textura04 azul_gris' }
  expose(:recovery) { PasswordRecovery.new(params[:id]) }

  def new
  end

  def show
  end

  def create
    if recovery.send_email(params[:password_recovery][:email])
      redirect_to root_path, notice: t('password_recoveries.notices.created')
    else
     redirect_to new_password_recovery_path,
       notice: t('password_recoveries.notices.user_not_found')
    end 
  end

  def update
    if recovery.update_password(params[:password_recovery])
      redirect_to login_path,
        notice: t('password_recoveries.notices.updated')
    else
      redirect_to recovery,
        notice: t('password_recoveries.notices.update_failed')
    end
  end
end
