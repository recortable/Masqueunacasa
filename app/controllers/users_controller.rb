class UsersController < ApplicationController
  respond_to :html
  before_filter :load_subdomain_group

  expose(:users) { current_group.users }
  expose(:user)

  def index
    respond_with users
  end

  def show
    respond_with user
  end

  def create
    if user.save
      flash[:notice] = 'notice.users.created' 
      login_user(user)
    end
    respond_with user
  end

  def enter
    return if Rails.env.production? && !current_user.admin?
    user = User.find params[:id]
    login_user(user, bypass: true)
    redirect_to root_path
  end
end
