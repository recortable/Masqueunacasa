class ProposalsController < ApplicationController
  respond_to :html

  expose(:proposals) { Proposal.published }
  expose(:proposal)

  def index
    authorize! :read, Proposal
    respond_with proposals
  end

  def show
    authorize! :read, proposal
    respond_with proposal
  end

  def new
    authorize! :new, proposal
    respond_with proposal
  end

  def create
    proposal.user = current_user
    authorize! :create, proposal
    flash[:notice] = t('proposals.notices.created') if proposal.save
    respond_with proposal
  end

  def update
    authorize! :update, proposal
    flash[:notice] = t('proposals.notices.updated') if proposal.update_attributes(params[:proposal])
    respond_with proposal
  end


end
