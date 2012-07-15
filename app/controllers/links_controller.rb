class LinksController < ApplicationController
  expose_parent :resource, [:experiencie]
  expose(:links) { resource.links }
  expose(:link)

  def new
    authorize! :update, resource
  end

  def create
    authorize! :update, resource
    link.user = current_user
    flash[:notice] = 'Guardado!' if link.save
    respond_with link, location: resource
  end
end
