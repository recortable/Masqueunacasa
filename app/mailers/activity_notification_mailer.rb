class ActivityNotificationMailer < ActionMailer::Base
  default from: '"Masqueuncasa" <hola@masqueunacasa.org>'

  def activity_email(user)
    mail to: user.email, subject: "Bon dia"
  end
end
