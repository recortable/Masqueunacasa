class UsersController < ApplicationController
  respond_to :html

  expose(:users) { User.all }
  expose(:user)

  def index
    respond_with users
  end

  def show
    respond_with user
  end
end
