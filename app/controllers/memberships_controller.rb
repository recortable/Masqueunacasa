# encoding: utf-8
class MembershipsController < ApplicationController
  respond_to :html
  before_filter :load_subdomain_group

  expose(:users) { User.all }
  expose(:memberships) { current_group.memberships }
  expose(:membership)

  def index
    respond_with memberships
  end

  def new
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

end
