class ProposalsController < ApplicationController
  respond_to :html

  include HasListActions
  expose(:proposals) { Proposal.published }
  expose(:proposal)

  def index
    authorize! :index, Proposal
    respond_with proposals
  end

  def show
    authorize! :read, proposal
    respond_with proposal
  end

  expose(:category) { Category.find params[:category_id] }
  def new
    proposal.category = category
    proposal.phase = category.phase
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

  def up
    respond_with move_up(proposal), location: proposal.category
  end

  def down
    respond_with move_down(proposal), location: proposal.category
  end

end
