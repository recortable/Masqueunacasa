class DashboardController < ApplicationController
  #before_filter :authenticate_user!
  expose (:themes) do
    if action_name == 'welcome'
      'textura_inicio azul_neon'
    else
      'textura01 azul_neon'
    end
  end
  expose(:site) { Site.new }
  expose(:post_list) { site.latest_posts(params[:page]) }
  expose(:groups) { site.groups.reorder('admin DESC, title ASC') }
  expose(:archive_posts) { Post.all }
  expose(:posts_archive) { Post.archive_for(site.posts) }

  def dashboard
  end

  def welcome
  end

  def community
  end

  def blog
  end

  expose(:activities) { Activities.new }
  def mailer
  end

  def cuatrocerocuatro
    render action: 'cuatrocerocuatro', layout: 'static'
  end

  def quinientos
    render action: 'quinientos', layout: 'static'
  end
end
