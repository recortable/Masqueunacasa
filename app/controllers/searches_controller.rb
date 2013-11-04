class SearchesController < ApplicationController
  respond_to :html

  def show
    @search =
      if params[:query]
        Search.new(query: params[:query])
      else
        Search.new
      end
    respond_with @search
  end
end

