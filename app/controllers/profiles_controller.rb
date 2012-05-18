class ProfilesController < ApplicationController
  respond_to :html
  expose(:group) { current_group }
  expose(:message) { Message.new(resource: group) }

  def show
    authorize! :read, group
    respond_with group
  end

  def edit
    authorize! :edit, group
    respond_with group
  end
end
