class DashboardController < ApplicationController
  #before_filter :authenticate_user!
  expose (:themes) { 'textura01 azul_neon'}

  def index
  end
end
