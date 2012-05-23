class CategoriesController < ApplicationController
  respond_to :html

  expose(:phase) { Phase.find params[:phase_id] }
  expose(:categories) { phase.categories }
  expose(:category)

  def new
    authorize! :create, Category
    respond_with category
  end
end
