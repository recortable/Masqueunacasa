class ExperienciesController < ApplicationController
  respond_to :html

  expose(:related_proposal) { Proposal.find(params[:p]) if params[:p].present? }
  expose(:experiencies) { Experiencie.scoped }
  expose(:experiencie) 

  def index
    authorize! :index, Experiencie
    respond_with experiencies
  end

  def show
    authorize! :read, experiencie
    experiencie.increment_view_counter
    respond_with experiencie
  end

  def new
    authorize! :create, Experiencie
    experiencie.related_proposal_id = related_proposal.id if related_proposal.present?
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
    experiencie.attributes = params[:experiencie]
    flash[:notice] = t('experiencies.notices.updated') if experiencie.save
    respond_with experiencie 
  end

  def destroy
    authorize! :destroy, experiencie
    flash[:notice] = t('experiencies.notices.destroyed') if experiencie.destroy
    respond_with experiencie, location: experiencies_path
  end
end
