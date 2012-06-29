class SearchesController < ApplicationController
  expose(:search) { Search.new(params) }
  def show

  end
end
