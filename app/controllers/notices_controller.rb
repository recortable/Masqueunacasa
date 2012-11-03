class NoticesController < ApplicationController
  respond_to :html
  before_filter :require_admin

  expose(:list) { params[:l].present? ? params[:l] : nil }
  expose(:notices) do
    list ? Notice.where(list: params[:l]) :
      Notice.scoped
  end
  expose(:notice)
  expose_resource :notice, actions: :all

  def index
    if list.blank?
      redirect_to url_for(l: Notice::LISTS[0])
    else
      index!
    end
  end

  def new
    notice.list = params[:l]
    new!
  end

  def show
    redirect_to notices_path(l: notice.list)
  end

  def up
    authorize! :update, notice
    notice.move_higher
    respond_with notice
  end

  def down
    authorize! :update, notice
    notice.move_lower
    respond_with notice
  end
end
