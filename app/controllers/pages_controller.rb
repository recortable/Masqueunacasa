class PagesController < ApplicationController
  respond_to :html
  before_filter :require_user, except: [:index, :show]

  expose(:themes) { 'textura02 naranja group' }
  expose_parent :group, [:parent], default: Proc.new { current_group }
  expose(:docs) { group.pages.all }
  expose(:doc) { params[:id].present? ? Page.find(params[:id]) : Page.new }

  def index
    respond_with docs
  end

  def show
    authorize! :show, doc
    doc.increment_view_counter
    respond_with doc
  end

  def new
    authorize! :new, Page
  end

  def edit
    respond_with doc
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
