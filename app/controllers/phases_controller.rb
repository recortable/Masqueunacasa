class PhasesController < ApplicationController
  respond_to :html
  expose(:themes) { 'textura_habitapedia naranja' }
  expose(:phases) { Phase.all }
  expose(:phase)
  expose(:categories) { Category.all }
  expose(:habitapedia_notices) { Notice.list('habitapedia') }


  def index
    authorize! :index, Phase
    @active_tab = "habitapedia"
    respond_with phases
  end

  def show
    authorize! :read, phase
    phase.increment_view_counter
    redirect_to phases_path
  end

  def new
    authorize! :new, Phase
    respond_with phase
  end

  def edit
    authorize! :edit, phase
    respond_with phase
  end

  def create
    authorize! :create, phase
    flash[:notice] = t('phases.notices.created') if phase.save
    respond_with phase
  end

  def update
    authorize! :update, phase
    flash[:notice] = t('phases.notices.updated') if phase.update_attributes(params[:phase])
    respond_with phase
  end
end
