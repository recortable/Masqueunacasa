class UsersController < ApplicationController
  respond_to :html
  before_filter :group_or_site_from_subdomain

  expose(:users) { group.all }
  expose(:user)

  def index
    respond_with users
  end

  def show
    respond_with user
  end
end
