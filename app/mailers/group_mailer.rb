class GroupMailer < ActionMailer::Base
  default from: "hola@masqueunacasa.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.group_mailer.message_email.subject
  #
  def message_to_group(message, recipient)
    @message = message
    @title = t('group_mailer.title')
    @avatar = message.group.avatar_image_url
    @sender = message.user.name || "Alguien"
    
    mail to: recipient, 
         subject: t("group_mailer.message_to_group.subject", 
          group: message.group.name) do |format|
      format.html {render layout: 'group_email_layout' }
      format.text
    end
  end

  def message_to_user(message)
    @message = message

    mail to: User.find(message.resource_id).email,
         subject: t("group_mailer.message_to_user.subject")
  end

  private
end
