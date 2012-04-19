class GroupsController < ApplicationController
  respond_to :html

  expose(:groups) { Group.all }
  expose(:group)

  def index
    respond_with groups
  end

  def show
    respond_with group
  end

  def new
    authorize! :new, Group
  end

  def create
    authorize! :create, group
    flash[:notice] = t('.created') if group.save
    respond_with group
  end
end