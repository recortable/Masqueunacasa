class ProfilesController < ApplicationController
  respond_to :html

  def edit
    respond_with current_group
  end

  def update
   current_group.update_attributes(params[:group])
   redirect_to root_url(subdomain: current_group.slug)
  end
end
