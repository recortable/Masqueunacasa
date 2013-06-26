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

  add_breadcrumb 'Mas que una casa', :root_path

  def dashboard
  end

  def search
  end

  expose(:welcome_notices) { Notice.list('inicio') }
  def welcome
    @active_tab = 'home'
    @description_mq1c = HelpText.find_by_identf('descripcion_mq1c_home')
    @objectives = HelpText.where(["identf in (?)", ["objetivo1_home", "objetivo2_home", "objetivo3_home"]]).
      order("identf")
  end

  def community
    breadcrumb_for_community
  end

  def mailer
    redirect_to '/mailer/admin'
  end

  def admin_area
    authorize! :read, :admin_area
    breadcrumb_for_admin_area
    render layout: 'one_column'
  end

  def cuatrocerocuatro
    render action: 'cuatrocerocuatro', layout: 'static'
  end

  def quinientos
    render action: 'quinientos', layout: 'static'
  end
end
