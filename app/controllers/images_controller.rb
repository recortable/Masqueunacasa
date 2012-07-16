class ImagesController < ApplicationController
  respond_to :html
  expose_parent :document, [:experiencie]
  expose(:images) { document.images }
  expose(:image)

  def index
    
  end

  def new
    render action: 'index'
  end

  def create
    image.user = current_user
    flash[:notice] = "imagen cargada" if image.save
    respond_with image, location: [document, :images]
  end

  def destroy
    
  end
end