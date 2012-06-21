class ExperienciesController < ApplicationController
  respond_to :html

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
end
