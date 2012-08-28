# encoding: utf-8
class LinksController < ApplicationController
  respond_to :html
  expose_parent :resource, [:experiencie, :proposal]
  expose(:links) { resource.links }
  expose(:link)

  def new
    authorize! :update, resource
    polymorphic_breadcrumb_for(resource)
    add_breadcrumb 'Añadir recurso', polymorphic_path([:new, resource, :link])
    respond_with link
  end

  def edit
    authorize! :update, resource
    polymorphic_breadcrumb_for(resource)
    add_breadcrumb 'Editar', polymorphic_path([:edit, resource, link])
    respond_with link
  end

  def show
    link = Link.find params[:id]
    redirect_to link.document
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
