class ActivityNotificationMailer < ActionMailer::Base
  helper :comments

  default from: '"Masqueuncasa" <hola@masqueunacasa.org>'

  def email_for_admins(user, activities)
    @activities = activities
    mail to: user.email, subject: "Bon dia"
  end
end
