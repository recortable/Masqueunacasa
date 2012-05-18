class ProfilesController < ApplicationController
  respond_to :html
  expose(:group) { current_group }
  expose(:message) { Message.new(resource: group) }

  def show
    respond_with group
  end

  def edit
    respond_with group
  end
end
