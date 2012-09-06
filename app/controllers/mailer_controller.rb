class MailerController < ApplicationController
  before_filter :require_admin, only: [:set, :test]
  expose(:activities) { Activities.new }

  def info
  end

  def test 
    UserMailer.activity_email(current_user, activities).deliver
    render action: 'info'
  end

  def activity
    if activities.deliver?
      users = activities.activity_users
      users.each {|u| UserMailer.activity_email(u, activities).deliver }
      activities.last_mail_at = Time.now
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
