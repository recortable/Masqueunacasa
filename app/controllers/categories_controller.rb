class CategoriesController < ApplicationController
  respond_to :html

  include HasListActions
  expose(:phase) { Phase.find params[:phase_id] }
  expose(:parent) { params[:phase_id].present? ? phase : nil }
  expose(:categories) { parent.present? ? parent.categories : Category.scoped }
  expose(:category)

  def dahsboard
    respond_with categories
  end

  def index
    authorize! :index, Category
    respond_with categories
  end

  def new
    authorize! :create, Category
    respond_with category
  end

  def show
    if params[:phase_id].blank?
      c = Category.find params[:id]
      redirect_to url_for([c.phase, c])
    else
      authorize! :read, category
      category.increment_view_counter

      breadcrumb_for_category(category)
      respond_with category
    end
  end

  def edit
    authorize! :update, category

    breadcrumb_for_category(category)
    add_breadcrumb 'Editar', polymorphic_path([:edit, phase, category])
    respond_with category
  end

  def create
    category.user = current_user
    authorize! :create, category

    if category.save
      flash[:notice] = t('categories.notices.created') if category.save
      respond_with [category.phase, category]
    else
      render 'new'
    end
  end

  def update
    authorize! :update, category
    category.attributes = params[:category]
    flash[:notice] = t('categories.notices.updated') if category.save
    respond_with category
  end

  def destroy
    authorize! :destroy, category
    flash[:notice] = t('categories.notices.destroyed') if category.destroy
    respond_with [phase, category], location: phase
  end

  def up
    respond_with move_up(category), location: category.phase
  end

  def down
    respond_with move_down(category), location: category.phase
  end
end
