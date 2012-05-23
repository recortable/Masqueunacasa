class CategoriesController < ApplicationController
  respond_to :html

  expose(:phase) { Phase.find params[:phase_id] }
  expose(:categories) { phase.categories }
  expose(:category)

  def new
    authorize! :create, Category
    respond_with category
  end

  def show
    authorize! :read, category
    respond_with category
  end

  def edit
    authorize! :edit, category
    respond_with category
  end

  def create
    category.user = current_user
    category.phase = phase
    authorize! :create, category
    flash[:notice] = t('categories.notices.created') if category.save
    respond_with [phase, category]
  end

  def update
    authorize! :update, category
    category.attributes = params[:category]
    flash[:notice] = t('categories.notices.updated') if category.save
    respond_with [phase, category]
  end
end
