# encoding: utf-8
class UserMailer < ActionMailer::Base
  default from: "hola@masqueunacasa.org"
  HOST = Rails.env.production? ? 'masqueunacasa.org' : 'lvh.me:3000'

  def password_recovery_email(user_id)
    @user = User.find(user_id)
    @host = HOST
    
    mail to: @user.email, 
      subject: 'Instrucciones para recuperar contrasea'
  end
end

