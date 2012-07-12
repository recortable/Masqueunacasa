class GroupsController < ApplicationController
  respond_to :html

  expose(:groups) { Group.all }
  expose(:group)
  expose(:themes) {'textura07 negro'}
  expose(:message) { Message.new(resource: group) }

  def index
    respond_with groups
  end

  def show
    redirect_to_group(group)
  end

  # El root (/) con subdominio
  def root
    redirect_to_group(current_group)
  end

  def new
    authorize! :new, Group
  end

  def edit
    authorize! :update, group
    respond_with group
  end

  def create
    group.user = current_user
    authorize! :create, group
    flash[:notice] = t('.created') if group.save
    respond_with group
  end

  def update
    authorize! :update, group
    flash[:notice] = t('groups.notices.updated') if group.update_attributes(params[:group])
    respond_with group
  end

  private
  def redirect_to_group(group)
    if group.has_blog?
      redirect_to posts_url(subdomain: group.subdomain)
    else
      redirect_to profile_url(subdomain: group.subdomain)
    end
  end

end
