class MailerController < ApplicationController
  before_filter :require_admin, only: [:set, :test]
  expose(:activities) { Activities.new }

  def info
  end

  def test 
    UserMailer.activity_email(current_user, activities).deliver
    flash[:notice] = "Email de actividad enviado a #{current_user.email}"
    render action: 'info'
  end

  def activity
    if activities.deliver?
      users = User.where(admin: true)
      users.each {|u| UserMailer.activity_email(u, activities).deliver }
      activities.last_mail_at = Time.now
      flash[:notice] = "Email de actividad enviado (#{users.count} emails)"
    else
      flash[:notice] = 'No era necesario enviar el email'
    end
    render action: 'info'
  end

  def set
    begin
      date = Date.parse params[:d]
      activities.last_mail_at = date.to_time
    end
    redirect_to action: 'info'
  end

end
