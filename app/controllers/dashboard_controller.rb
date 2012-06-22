class DashboardController < ApplicationController
  #before_filter :authenticate_user!
  expose (:themes) { 'textura01 azul_neon'}
  expose(:site) { Site.new }
  expose(:posts) { site.latest_posts(params[:page]) }
  expose(:community_groups) { site.groups.community }
  expose(:archive_posts) { Post.all }
  expose(:posts_archive) { Post.archive_for(site.posts) }

  def dashboard
  end

  def welcome
    # UserMailer.registration_confirmation().deliver
  end

  def community
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
