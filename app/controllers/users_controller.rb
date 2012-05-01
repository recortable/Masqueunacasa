class UsersController < ApplicationController
  respond_to :html
  before_filter :load_subdomain_group

  expose(:users) { group.users }
  expose(:user)

  def index
    respond_with users
  end

  def show
    respond_with user
  end

  def enter
    return if Rails.env.production? && !current_user.admin?
    user = User.find params[:id]
    sign_in(user, bypass: true)
    redirect_to root_path
  end
end
