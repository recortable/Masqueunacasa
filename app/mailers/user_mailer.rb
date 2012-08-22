# encoding: utf-8
class UserMailer < ActionMailer::Base
  default from: "hola@masqueunacasa.org"
  layout 'mquc_email'

  def activity_email(user, activities)
    @title = "Actividad en masqueunacasa.org"
    @user = user
    @activities = activities

    mail to: @user.email, subject: @title
  end

  def password_recovery_email(user_id)
    @title = 'Instrucciones para recuperar contraseña'
    @user = User.find(user_id)
    
    mail to: @user.email, subject: @title
  end
end

