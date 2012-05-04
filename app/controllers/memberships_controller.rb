class MembershipsController < ApplicationController
  respond_to :html
  before_filter :load_subdomain_group

  expose(:users) { User.all }
  expose(:memberships) { current_group.memberships }

  def index
    respond_with memberships
  end

  def new
  end
  
end
