class GroupMailer < ActionMailer::Base
  default from: "hola@masqueunacasa.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.group_mailer.message_email.subject
  #
  def message_to_group(message)
    @message = message

    mail to: recipients(message.group),
         subject: t("group_mailer.message_to_group.subject",
                   group: message.group.name)
  end

  def message_to_user(message)
    @message = message

    mail to: User.find(message.resource_id).email,
         subject: t("group_mailer.message_to_user.subject")
  end

  private

  def recipients(group, scope = 'members')
    recipients = ""
    if scope == "all"
      return group.users.map(&:email)
    elsif scope == "members"
      group.users.each do |user|
        if group.member_level?(user, "member") | group.member_level?(user, "owner")
          recipients = recipients + ", " + user.email
        end
      end
    elsif scope == "admin"
      group.users.each do |user|
        if group.member_level?(user, "owner")
          recipients = recipients + ", " + user.email
        end
      end
    end
    recipients
  end
end
