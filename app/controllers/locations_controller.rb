# encoding: utf-8
class LocationsController  < ApplicationController
  respond_to :html
  expose_parent :parent, [:user, :experiencie], default: Proc.new { current_group }
  expose(:map_locations) { Location.scoped }
  expose(:locations) { parent.locations }
  expose(:location)

  # Este es el mapa asociado a Site.new
  def map

  end
 
  def new
    authorize! :update, parent
    respond_with location
  end

  def edit
    authorize! :update, parent
    respond_with location
  end

  def create
    authorize! :update, parent
    flash[:notice] = "Localización guardada" if location.save
    respond_with location, location: parent_location    
  end

  def update
    authorize! :update, parent
    flash[:notice] = "Actualizado!" if location.save
    respond_with location, location: parent_location
  end

  def destroy
    authorize! :update, parent
    flash[:notice] = 'Borrado!' if location.destroy
    respond_with location, location: parent_location
  end

  private

  def parent_location
    if parent.class == Group
      profile_path
    else
      url_for(parent)
    end
  end
end  
