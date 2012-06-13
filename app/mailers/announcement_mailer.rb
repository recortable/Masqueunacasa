class AnnouncementMailer < ActionMailer::Base
  default from: "info@masqueunacasa.org"
  layout 'announcement_email'

  def probe(announcement, recipient)
    @notice = t('announcement_mailer.probe.test_mail')
    @announcement = announcement
    @avatar = announcement.group.avatar_image_url
    mail to: recipient, 
         subject: announcement.title,
         template_name: 'announcement_mailer' 
  end

  def send_email(announcement, recipient)
    @announcement = announcement
    @avatar = announcement.group.avatar_image_url
    mail to: recipient, 
         subject: announcement.title,
         template_name: 'announcement_mailer' 
  end
end
