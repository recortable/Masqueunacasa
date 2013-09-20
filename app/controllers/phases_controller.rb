class PhasesController < ApplicationController
  respond_to :html
  expose(:themes) { 'textura_habitapedia naranja' }
  expose(:phases) { Phase.all }
  expose(:phase)
  expose(:categories) { Category.where(filter_by).order(sort_by) }

  def index
    authorize! :index, Phase
    @active_tab = "habitapedia"
    respond_with phases
  end

  def show
    authorize! :read, phase
    phase.increment_view_counter
    respond_with phase
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

  private

  def filter_by
    filter = params[:phase]
    filter.present? ? ["phase_id = ?", filter] : nil
  end

  def sort_by
    %w{view_count}.include?(params[:sort_by]) ? "#{params[:sort_by]} #{direction}" : 'phase_id ASC, position ASC'
  end

  def direction
    %w{asc desc}.include?(params[:d]) ? params[:d] : 'asc'
  end
end
