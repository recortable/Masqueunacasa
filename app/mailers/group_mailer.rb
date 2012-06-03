class GroupMailer < ActionMailer::Base
  default from: "hola@masqueunacasa.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.group_mailer.message_email.subject
  #
  def message_email(message)
    @message = message

    mail to: message.group.users.map(&:email), 
         subject: t("group_mailer.message_email.subject", group: message.group.name)
  end
end
