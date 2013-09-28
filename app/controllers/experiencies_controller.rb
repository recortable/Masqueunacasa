class ExperienciesController < ApplicationController
  include ActionTracker

  respond_to :html

  expose(:themes) { 'textura09 negro' }
  expose(:related_proposal) { Proposal.find(params[:p]) if params[:p].present? }
  expose(:experiencies) { Experiencie.order(sort_by) }
  expose(:experiencie)

  def index
    authorize! :index, Experiencie
    breadcrumb_for_experiencies
    respond_with experiencies
  end

  def show
    authorize! :read, experiencie
    experiencie.increment_view_counter

    breadcrumb_for_experiencie(experiencie)
    respond_with experiencie
  end

  def edit
    authorize! :update, experiencie

    breadcrumb_for_experiencie(experiencie)
    add_breadcrumb "Editar", edit_experiencie_path(experiencie)
    respond_with experiencie
  end

  def new
    authorize! :create, Experiencie
    if related_proposal.present?
      experiencie.related_proposal_id = related_proposal.id
      breadcrumb_for_proposal(related_proposal)
    else
      breadcrumb_for_experiencies
    end
    respond_with experiencie
  end

  def create
    experiencie.user = current_user
    authorize! :create, experiencie
    if track_action(experiencie, :save)
      flash[:notice] = t('experiencies.notices.created')
    end
    respond_with experiencie
  end

  def update
    authorize! :update, experiencie
    if track_action(experiencie, :save)
      flash[:notice] = t('experiencies.notices.updated')
    end
    respond_with experiencie
  end

  def destroy
    authorize! :destroy, experiencie
    if track_action(experiencie, :destroy)
      flash[:notice] = t('experiencies.notices.destroyed')
    end
    respond_with experiencie, location: experiencies_path
  end

  private

  def sort_by
    %w{view_count}.include?(params[:sort_by]) ? "#{params[:sort_by]} #{direction}" : "updated_at desc"
  end

  def direction
    %{asc desc}.include?(params[:d]) ? params[:d] : 'asc'
  end
end
