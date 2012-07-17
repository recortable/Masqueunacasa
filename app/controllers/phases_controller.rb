class PhasesController < ApplicationController
  respond_to :html
  expose(:phases) { Phase.all }
  expose(:phase)

  def index
    authorize! :index, Phase
    respond_with phases
  end

  def show
    redirect_to phases_path
    # authorize! :read, phase
    # phase.increment_view_counter
    # respond_with phase
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
