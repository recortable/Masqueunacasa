class LinksController < ApplicationController
  respond_to :html
  expose_parent :resource, [:experiencie, :proposal]
  expose(:links) { resource.links }
  expose(:link)

  def new
    authorize! :update, resource
  end

  def edit

  end

  def create
    authorize! :update, resource
    flash[:notice] = 'Guardado!' if resource.add_link(link, current_user)
    respond_with link, location: resource
  end

  def update
    authorize! :update, resource
    flash[:notice] = 'Guardado' if link.save
    respond_with link, location: resource
  end

  def destroy
    authorize! :update, resource
    flash[:notice] = 'Borrado' if link.destroy
    respond_with link, location: resource
  end
end
