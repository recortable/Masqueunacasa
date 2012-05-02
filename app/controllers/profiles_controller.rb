class ProfilesController < ApplicationController
  respond_to :html
  before_filter :load_subdomain_group

  def edit
    respond_with current_group
  end

  def update
   current_group.update_attributes(params[:group])
   redirect_to root_url(subdomain: current_group.slug)
  end
end
