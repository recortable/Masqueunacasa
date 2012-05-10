class PostsController < ApplicationController
  respond_to :html
  before_filter :require_user, except: [:index, :show]

  expose(:themes) { current_group.site? ? 'textura03 azul_gris masq1casa' : 'textura02 naranja group' }
  expose(:posts) { current_group.posts.order('created_at DESC').limit(10) }
  expose(:post)
  expose(:post_archive) do 
    current_group.posts.select(Post::ARCHIVE_COLUMNS).group_by { |post| post.published_at.beginning_of_month }
  end

  def index
    respond_with posts
  end

  def show
    respond_with post
  end

  def new
    authorize! :new, Post
  end

  def edit
    respond_with post
  end

  def create
    post.user = current_user
    post.group = current_group
    authorize! :create, post
    flash[:notice] = t('notice.posts.created') if post.save
    respond_with post
  end

  def update
    flash[:notice] = t('notice.posts.updated') if post.update_attributes(params[:post])
    respond_with post
  end

  def destroy
    authorize! :delete, post
    flash[:notice] = 'Borrado' if post.destroy
    respond_with post, location: posts_path
  end

end
