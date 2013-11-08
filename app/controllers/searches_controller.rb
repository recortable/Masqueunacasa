class SearchesController < ApplicationController
  respond_to :html

  def show
    @search =
      if params[:query]
        Search.new query: sanitized_query(params[:query])
      else
        Search.new
      end
    respond_with @search
  end

  private

  def sanitized_query(query)
    ActionController::Base.helpers.sanitize(query, tags: [])
  end
end

