class ProfilesController < ApplicationController
  respond_to :html
  expose(:group) { current_group }
  expose(:message) { Message.new(resource: group) }

  def show
    authorize! :read, group
    breadcrumb_for_group current_group
    respond_with group
  end

  def edit
    authorize! :edit, group
    breadcrumb_for_group current_group
    add_breadcrumb 'Editar perfil', edit_profile_path
    respond_with group
  end
end
