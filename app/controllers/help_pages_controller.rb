class HelpPagesController < ApplicationController
  respond_to :html

  expose(:help_page)

  def show

  end

  def new
    authorize! :create, HelpPage
    respond_with help_page
  end

  def create
    authorize! :create, HelpPage
    if help_page.save
      flash[:notice] = "Se ha creado correctamente"
      respond_with help_page, location: admin_area_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end
end
