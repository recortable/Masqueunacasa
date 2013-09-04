# encoding: utf-8
class ProposalsController < ApplicationController
  respond_to :html

  include HasListActions
  expose(:proposals) { Proposal.published }
  expose(:proposal)
  expose(:phase) { proposal.phase }

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
    add_breadcrumb 'Editar', edit_proposal_path(proposal)
    respond_with proposal
  end

  def new
    if params[:category_id]
      category = Category.find params[:category_id]
      proposal.category = category
      proposal.phase = category.phase
    end
    authorize! :new, proposal
    breadcrumb_for_category(proposal.category)
    add_breadcrumb 'Añadir propuesta', new_category_proposal_path(proposal.category, proposal)
    respond_with proposal
  end

  def create
    proposal.user = current_user
    authorize! :create, proposal
    if track_action(proposal) { save }
      flash[:notice] = t('proposals.notices.created')
    end

    respond_with proposal
  end

  def update
    authorize! :update, proposal
    if track_action(proposal) { save }
      flash[:notice] = t('proposals.notices.updated')
    end
    respond_with proposal
  end

  def destroy
    authorize! :destroy, proposal
    if track_action(proposal) { destroy }
      flash[:notice] = t('proposals.notices.destroyed')
    end
    respond_with proposal, location: [proposal.phase, proposal.category]
  end

  def up
    respond_with move_up(proposal), location: proposal.category
  end

  def down
    respond_with move_down(proposal), location: proposal.category
  end

end
