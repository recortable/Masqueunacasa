class AnnouncementMailer < ActionMailer::Base
  default from: "info@masqueunacasa.org"

  def probe(announcement, recipient)
    @notice = t('announcement_mailer.probe.test_mail')
    @announcement = announcement
    @avatar = announcement.group.avatar_image_url
    mail to: recipient, 
         subject: announcement.title,
         template_name: 'announcement_mailer' 
  end

  def send_email(announcement)
    @announcement = announcement
    @avatar = announcement.group.avatar_image_url
    recipients = recipients announcement 
    mail to: recipients, 
         subject: announcement.title,
         template_name: 'announcement_mailer' 
  end

  private

  # Me parece que esto está un poco java, no?
  def recipients(announcement)
    scope = announcement.scope
    group = announcement.group
    recipients = ""
    if scope == "all"
      return group.users.map(&:email)
    elsif scope == "members"
      group.users.each do |user|
        if group.member_level?(user, "member")
          recipients = recipients + ", " + user.email
        end
      end
    elsif scope == "admin"
      group.users.each do |user|
        if group.member_level?(user, "admin")
          recipients = recipients + ", " + user.email
        end
      end
    end
    recipients
  end
end
