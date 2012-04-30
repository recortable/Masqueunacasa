class Space::GroupsController < ApplicationController 
  respond_to :html
  include HasSpace

  def show
    respond_with group
  end

end
