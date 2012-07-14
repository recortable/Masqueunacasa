# encoding: utf-8
class LocationsController  < ApplicationController
  respond_to :html
  expose_parent :parent, [:group, :user]
  expose(:locations) { parent.locations }
  expose(:location)

  def new
    authorize! :update, parent
    respond_with location
  end

  def show
  end

  def create
    authorize! :update, parent
    flash[:notice] = "Localización guardada" if location.save
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