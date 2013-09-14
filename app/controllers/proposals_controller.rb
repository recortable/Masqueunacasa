# encoding: utf-8
class ProposalsController < ApplicationController
  include ActionTracker

  respond_to :html
  
  expose(:proposal)
  expose(:phase) { proposal.phase }

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
    if track_action(proposal, :save)
      flash[:notice] = t('proposals.notices.created')
    end

    respond_with proposal
  end

  def update
    authorize! :update, proposal
    if track_action(proposal, :save)
      flash[:notice] = t('proposals.notices.updated')
    end
    respond_with proposal
  end

  def destroy
    authorize! :destroy, proposal
    if track_action(proposal, :destroy)
      flash[:notice] = t('proposals.notices.destroyed')
    end
    respond_with proposal, location: [proposal.phase, proposal.category]
  end
end
