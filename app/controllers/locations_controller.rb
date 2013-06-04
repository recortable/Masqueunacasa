# encoding: utf-8
class LocationsController  < ApplicationController
  respond_to :html
  expose_parent :parent, [:user, :experiencie, :group]
  expose(:map_locations) { Location.scoped }
  expose(:locations) { parent.locations }
  expose(:location)

  expose(:with_banner) do
    parent.class == Group
  end

  # Este es el mapa asociado a Site.new
  def map

  end

  def new
    authorize! :update, parent
    polymorphic_breadcrumb_for(parent)
    add_breadcrumb 'Añadir localización', polymorphic_path([:new, parent, :location])
    respond_with location
  end

  def edit
    authorize! :update, parent
    polymorphic_breadcrumb_for(parent)
    add_breadcrumb 'Editar localización', polymorphic_path([:edit, parent, :location])
    respond_with location
  end

  def create
    location.user = current_user
    authorize! :update, parent
    flash[:notice] = "Localización guardada" if location.save
    respond_with location, location: url_for(parent)
  end

  def update
    authorize! :update, parent
    flash[:notice] = "Actualizado!" if location.save
    respond_with location, location: url_for(parent)
  end

  def destroy
    authorize! :update, parent
    flash[:notice] = 'Borrado!' if location.destroy
    respond_with location, location: url_for(parent)
  end
end

