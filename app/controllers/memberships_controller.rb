# encoding: utf-8
class MembershipsController < ApplicationController
  respond_to :html
  before_filter :load_subdomain_group

  expose(:users) { User.where(['id NOT IN (?)', current_group.members]) }
  expose(:memberships) { current_group.memberships }
  expose(:membership)

  def index
    authorize! :index, Membership
    respond_with memberships
  end

  def create
    user = User.find params[:u]
    if current_group.member?(user)
      redirect_to memberships_location, notice: 'Ya pertenecía a éste grupo'
    else
      membership.user = user
      membership.group = current_group 
      membership.state = params[:l] if ['member', 'request', 'follow'].include? params[:l]
      membership.state ||= 'member'
      flash[:notice] = 'Añadido!' if membership.save
      respond_with membership, location: memberships_location
    end
  end

  def destroy
    membership.destroy
    respond_with membership, location: memberships_location
  end

  private
  def memberships_location
      edit_profile_path
  end

end
