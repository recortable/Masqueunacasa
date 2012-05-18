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
    authorize! :show, group
    if group.subdomain?
      redirect_to root_url(subdomain: group.subdomain)
    else
    respond_with group
    end
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
end
