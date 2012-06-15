class AnnouncementMailer < ActionMailer::Base
  default from: "info@masqueunacasa.org"
  layout 'group_email_layout'

  def probe(announcement, recipient)
    @notice = t('announcement_mailer.probe.test_mail')
    @message = announcement
    @avatar = announcement.group.avatar_image_url
    mail to: recipient, 
         subject: announcement.title,
         template_name: 'announcement_mailer' 
  end

  def send_email(announcement, recipient)
    @message = announcement
    @avatar = announcement.group.avatar_image_url
    mail to: recipient, 
         subject: announcement.title do |format|
      format.html { render template: 'announcement_mailer/announcement_mailer' }
      format.text { render layout: nil, template: 'announcement_mailer/announcement_mailer' }
    end
  end
end
