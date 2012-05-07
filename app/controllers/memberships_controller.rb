# encoding: utf-8
class MembershipsController < ApplicationController
  respond_to :html
  before_filter :load_subdomain_group

  expose(:users) { User.all }
  expose(:memberships) { current_group.memberships }
  expose(:membership)

  def index
    authorize! :index, memberships
    respond_with memberships
  end

  def new
  end

  def edit
  end

  def create
    user = User.find params[:u]
    if current_group.member?(user)
      redirect_to memberships_path, notice: 'Ya pertenecía a éste grupo'
    else
      membership.user = user
      membership.group = current_group
      membership.state = 'member'
      flash[:notice] = 'Añadido!' if membership.save
      respond_with membership, location: memberships_path
    end
  end

  def update
    flash[:notice] = t('memberships.notices.updated') if membership.update_attributes(params[:membership])
    respond_with membership, location: memberships_path
  end

  def destroy
    membership.destroy
    respond_with membership, location: memberships_path
  end

end
