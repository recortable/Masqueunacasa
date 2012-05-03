class GroupMailer < ActionMailer::Base
  default from: "hola@masqueunacasa.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.group_mailer.message_email.subject
  #
  def message_email(message)
    @greeting = "Hi"

    mail to: "danigb@gmail.com", subject: "Probando"
  end
end
