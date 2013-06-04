class GroupsController < ApplicationController
  respond_to :html

  expose(:groups) { Group.all }
  expose(:group)
  expose(:themes) {'textura07 negro'}
  expose(:message) { Message.new(resource: group) }

  def index
    redirect_to community_path
  end

  def show
    breadcrumb_for_group group
    respond_with group
  end

  def new
    authorize! :new, Group
    breadcrumb_for_community
  end

  def edit
    authorize! :update, group
    breadcrumb_for_group group
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

  def destroy
    authorize! :destroy, group
    flash[:notice] = t('groups.notices.deleted') if group.destroy
    respond_with group, location: community_path
  end
end
