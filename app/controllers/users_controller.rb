class UsersController < ApplicationController
  respond_to :html

  expose(:themes) { 'textura04 azul_gris' }
  expose(:users) { site.users }
  expose(:user)
  expose(:message) { Message.new(resource: user) }

  def index
    respond_with users
  end

  def show
    respond_with user
  end

  def new
    respond_with user
  end

  def edit
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
