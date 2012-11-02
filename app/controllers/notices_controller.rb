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
end
