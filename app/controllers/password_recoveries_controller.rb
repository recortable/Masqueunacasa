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
      redirect_to root_path, notice: 'Hemos enviado las instrucciones a tu correo'
    else
     redirect_to new_password_recovery_path, notice: 'No hemos encontrado nadie registrado con este email'
    end 
  end

  def update
    if recovery.update_password(params[:password_recovery])
      redirect_to login_path, notice: 'Tu contraseña ha sido cambiada' 
    else
      redirect_to recovery, notice: 'Lo sentimos, no se ha podido cambiar tu contraseña. Inténtalo de nuevo.'
    end
  end
end
