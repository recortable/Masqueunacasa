class UsersController < ApplicationController
  respond_to :html
  before_filter :load_subdomain_group

  expose(:users) { group.all }
  expose(:user)

  def index
    respond_with users
  end

  def show
    respond_with user
  end
end
