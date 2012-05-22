class DashboardController < ApplicationController
  #before_filter :authenticate_user!
  expose (:themes) { 'textura01 azul_neon'}
  expose(:site) { Site.new }

  def dashboard
  end

  def welcome
  end

  def community
  end

  def cuatrocerocuatro
    render action: 'cuatrocerocuatro', layout: 'static'
  end

  def quinientos
    render action: 'quinientos', layout: 'static'
  end

end
