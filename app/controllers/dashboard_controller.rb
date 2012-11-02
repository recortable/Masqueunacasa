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
  expose(:site) { Site.new }
  expose(:post_list) { site.latest_posts(params[:page]) }
  expose(:groups) { site.groups.reorder('admin DESC, title ASC') }
  expose(:archive_posts) { Post.all }

  add_breadcrumb 'Mas que una casa', :root_path

  def dashboard
  end

  def search
  end

  expose(:welcome_notices) { Notice.list('inicio') }
  def welcome
  end

  def community
    add_breadcrumb 'Comunidad', community_path
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
