class DashboardController < ApplicationController
  #before_filter :authenticate_user!
  expose (:themes) { 'textura01 verde_neon'}

  def index
  end
end
