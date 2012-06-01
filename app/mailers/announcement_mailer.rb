class AnnouncementMailer < ActionMailer::Base
  include CurrentUser
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
    mail to: announcement.group.users.map(&:email), 
         subject: announcement.title,
         template_name: 'announcement_mailer' 
  end
end
