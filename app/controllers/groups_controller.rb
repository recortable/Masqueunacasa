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
    if track_action(group) { save }
      flash[:notice] = t('.created')
    end
    respond_with group
  end

  def update
    authorize! :update, group
    if track_action(group) { save }
      flash[:notice] = t('groups.notices.updated')
    end
    respond_with group
  end

  def destroy
    authorize! :destroy, group
    if track_action(group) { destroy }
      flash[:notice] = t('groups.notices.deleted')
    end
    respond_with group, location: community_path
  end
end
