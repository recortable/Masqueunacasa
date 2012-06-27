# encoding: utf-8
class MembershipsController < ApplicationController
  respond_to :html
  before_filter :load_subdomain_group

  expose(:users) { User.all }
  expose(:group) { params[:group_id].present? ? Group.find(params[:group_id]) : current_group }
  expose(:memberships) { group.memberships }
  expose(:membership)

  def index
    authorize! :index, Membership
    respond_with memberships
  end

  def new
  end

  def edit
  end

  def create
    user = User.find params[:u]
    if group.member?(user)
      redirect_to memberships_location, notice: 'Ya pertenecía a éste grupo'
    else
      membership.user = user
      membership.group = group 
      membership.state = params[:l] if ['member', 'request', 'follow'].include? params[:l]
      membership.state ||= 'member'
      flash[:notice] = 'Añadido!' if membership.save
      respond_with membership, location: memberships_location
    end
  end

  def update
    flash[:notice] = t('memberships.notices.updated') if membership.update_attributes(params[:membership])
    respond_with membership, location: memberships_location
  end

  def destroy
    membership.destroy
    respond_with membership, location: memberships_location
  end

  private
  def memberships_location
    if group.own_domain?
      edit_profile_path
    else
      edit_group_path(group)
    end
  end

end
