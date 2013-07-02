class HelpTextsController < ApplicationController

  respond_to :html

  expose(:help_text)

  def show

  end

  def new
    authorize! :create, HelpText
  end

  def create
    if help_text.save
      flash[:notice] = "Texto de ayuda creado correctamente!"
      respond_with help_text, location: admin_area_path
    else
      render 'new'
    end
  end

  def edit
    authorize! :update, help_text
  end

  def update
    authorize! :update, help_text
    if help_text.save
      flash[:notice] = "Texto de ayuda guardado correctamente!"
      respond_with help_text, location: admin_area_path
    else
      render 'edit'
    end
  end

  def destroy
    authorize! :destroy, help_text
    if help_text.destroy
      flash[:notice] = "El texto de ayuda ha sido borrado."
    else
      flash[:notice] = "No se ha podido borrar el texto de ayuda"
    end
    respond_with help_text, location: admin_area_path
  end
end
