class ExperienciesController < ApplicationController
  include SlugRedirections

  respond_to :html

  expose(:themes) { 'textura09 negro' }
  expose(:related_proposal) { Proposal.find(params[:p]) if params[:p].present? }
  expose(:experiencies) { Experiencie.order('updated_at DESC') }
  expose(:experiencie)

  def index
    authorize! :index, Experiencie

    breadcrumb_for_experiencies
    respond_with experiencies
  end

  def dashboard
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
    flash[:notice] = t('experiencies.notices.created') if experiencie.save
    respond_with experiencie
  end

  def update
    authorize! :update, experiencie
    flash[:notice] = t('experiencies.notices.updated') if experiencie.save
    respond_with experiencie 
  end

  def destroy
    authorize! :destroy, experiencie
    flash[:notice] = t('experiencies.notices.destroyed') if experiencie.destroy
    respond_with experiencie, location: experiencies_path
  end
end
