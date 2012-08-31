class PagesController < ApplicationController
  respond_to :html
  before_filter :require_user, except: [:index, :show]

  expose(:themes) { 'textura02 naranja group' }
  expose_parent :group, [:parent], default: Proc.new { current_group }
  expose(:pages) { group.pages.all }
  expose(:page) 

  expose(:docs) { pages }
  expose(:doc) { page }

  def index
    breadcrumb_for_pages current_group
    respond_with docs
  end

  def show
    authorize! :show, doc
    doc.increment_view_counter
    breadcrumb_for_page page
    respond_with doc
  end

  def new
    authorize! :new, Page
  end

  def edit
    respond_with doc
    add_breadcrumb 'Editar', edit_page_path(page)
  end

  def create
    doc.user = current_user
    doc.group = group
    doc.body_type ||= 'markdown'
    authorize! :create, doc
    flash[:notice] = t('pages.notices.created') if doc.save
    respond_with doc
  end

  def update
    flash[:notice] = t('pages.notices.updated') if doc.save
    respond_with doc
  end

  def destroy
    authorize! :delete, doc
    flash[:notice] = 'Borrado' if doc.destroy
    respond_with doc, location: pages_path
  end

end
