class SectionsController < ApplicationController
  respond_to :html

  expose(:proposal) { Proposal.find params[:proposal_id] }
  expose(:sections) { proposal.sections(:es) }
  expose(:section)

  def new
    authorize! :create, section
  end

  def edit
    authorize! :edit, section
  end

  def create
    section.proposal = proposal
    section.lang = I18n.locale
    section.body_type ||= 'markdown'
    authorize! :create, section
    section.save
    respond_with section, location: proposal
  end

  def update
    section.attributes = params[:proposal]
    authorize! :update, section
    section.save
    respond_with section, location: proposal
  end
  
end
