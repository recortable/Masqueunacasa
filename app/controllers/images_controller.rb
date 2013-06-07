class ImagesController < ApplicationController
  respond_to :html
  expose_parent :document, [:experiencie]
  expose(:images) { document.images }
  expose(:image)

  def index
    authorize! :update, document
  end

  def new

  end

  def edit

  end

  def create
    authorize! :update, document
    image.user = current_user
    flash[:notice] = "Imagen cargada!" if image.save
    respond_with image, location: [document, :images]
  end

  def update
    authorize! :update, document
    flash[:notice] = "Imagen actualizada!" if image.save
    respond_with image, location: [document, :images]
  end

  def destroy
    authorize! :update, document
    flash[:notice] = "Imagen borrada!" if image.destroy
    respond_with image, location: [document, :images]
  end

  def up
    img = Image.find params[:id]
    img.move_higher
    respond_with img, location: [img.imageable, :images]
  end

  def down
    img = Image.find params[:id]
    img.move_lower
    respond_with img, location: [img.imageable, :images]
  end
end
