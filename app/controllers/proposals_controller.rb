class ProposalsController < ApplicationController
  respond_to :html

  include HasListActions
  expose(:proposals) { Proposal.published }
  expose(:proposal)

  def index
    redirect_to phases_path
  end

  def dashboard
    authorize! :index, Proposal
    respond_with proposals
  end

  def show
    authorize! :read, proposal
    proposal.increment_view_counter

    breadcrumb_for_proposal(proposal)
    respond_with proposal
  end

  def edit
    authorize! :update, proposal

    breadcrumb_for_proposal(proposal)
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

  def destroy
    authorize! :destroy, proposal
    flash[:notice] = t('proposals.notices.destroyed') if proposal.destroy
    respond_with proposal, location: [proposal.phase, proposal.category]
  end

  def up
    respond_with move_up(proposal), location: proposal.category
  end

  def down
    respond_with move_down(proposal), location: proposal.category
  end

end
