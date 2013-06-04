# encoding: utf-8
class MembershipsController < ApplicationController
  respond_to :html

  expose(:group) { Group.find(params[:group_id]) }
  expose(:users) { User.where(['id NOT IN (?)', group.members]) }
  expose(:memberships) { group.memberships }
  expose(:membership)

  def index
    authorize! :index, Membership
    respond_with memberships
  end

  def new
    authorize! :create, Membership
  end

  def create
    user = User.find params[:u]
    if group.member?(user)
      redirect_to group_path(group), notice: 'Ya pertenecía a éste grupo'
    else
      membership.user = user
      membership.group = group
      flash[:notice] = 'Añadido!' if membership.save
      respond_with membership, location: group_path(group)
    end
  end

  def destroy
    membership.destroy
    respond_with membership, location: group_path(group)
  end

  private
  def memberships_location
      edit_profile_path
  end

end
