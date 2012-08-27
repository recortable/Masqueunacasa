class UsersController < ApplicationController
  respond_to :html

  expose(:themes) { 'textura04 azul_gris' }
  expose(:users) { site.users }
  expose(:user)
  expose(:activity) { Activities.user_activity(user) }
  expose(:message) { Message.new(resource: user) }

  def index
    breadcrumb_for_users
    respond_with users
  end

  def show
    if params[:id] != user.to_param
      redirect_to user, status: 301
    else
      authorize! :show, user
      breadcrumb_for_user(user)
      user.increment_view_counter
      respond_with user
    end
  end

  def new
    respond_with user
  end

  def edit
    authorize! :update, user, current_user
    respond_with user
  end

  def create
    if user.save
      flash[:notice] = t('users.notices.created')
      login_user(user)
    end
    respond_with user
  end

  def update
    authorize! :update, user, current_user
    flash[:notice] = t('users.notices.updated') if user.update_attributes(params[:user])
    respond_with user
  end

  def enter
    return if Rails.env.production? && !current_user.admin?
    user = User.find params[:id]
    login_user(user, bypass: true)
    redirect_to root_path
  end
end
