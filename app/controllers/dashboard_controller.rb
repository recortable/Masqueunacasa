class DashboardController < ApplicationController
  #before_filter :authenticate_user!
  expose (:themes) do
    if action_name == 'welcome'
      'textura_inicio azul_neon'
    elsif action_name == 'community'
      'textura08 rojo'
    else
      'textura01 azul_neon'
    end
  end
  expose(:groups) { Group.all }

  add_breadcrumb 'Mas que una casa', :root_path

  def dashboard
  end

  def search
  end

  expose(:welcome_notices) { Notice.list('inicio') }
  def welcome
    @active_tab = 'home'
  end

  def community
    breadcrumb_for_community
  end

  def mailer
    redirect_to '/mailer/admin'
  end

  def blog
  end

  def cuatrocerocuatro
    render action: 'cuatrocerocuatro', layout: 'static'
  end

  def quinientos
    render action: 'quinientos', layout: 'static'
  end
end
