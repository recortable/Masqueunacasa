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
    users = User.where(admin: true)
    users.each {|u| UserMailer.activity_email(u, activities).deliver }

    flash[:notice] = "Email de actividad enviado (#{users.count} emails)"
    render action: 'info'
  end

  def set
    begin
      time = Date.parse params[:q]
      activities.last_mail_at = time
    end
    redirect_to action: 'info'
  end

end
