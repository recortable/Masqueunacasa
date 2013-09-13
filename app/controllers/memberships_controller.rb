# encoding: utf-8
class MembershipsController < ApplicationController
  respond_to :html

  expose(:group) { Group.find(params[:group_id]) }
  expose(:users) { User.where(['id NOT IN (?)', group.members]) }
  expose(:memberships) { group.memberships }
  expose(:membership)

  def index
    respond_with memberships
  end

  def new
    authorize! :create, Membership
  end

  def create
    user = User.find params[:u]
    if group.member?(user)
      redirect_to group_memberships_path(group),
        notice: t('memberships.notices.already_member')
    else
      membership.user = user
      membership.group = group
      if membership.save
        flash[:notice] = t 'memberships.notices.added', group: group.title, user: user.name
      end
      respond_with membership, location: group_memberships_path(group)
    end
  end

  def destroy
    membership.destroy
    respond_with membership, location: group_memberships_path(group)
  end

  private
  def memberships_location
      edit_profile_path
  end

end
