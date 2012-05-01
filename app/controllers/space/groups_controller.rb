class Space::GroupsController < ApplicationController 
  respond_to :html
  include HasSpace

  def show
    redirect_to posts_path
  end

end
