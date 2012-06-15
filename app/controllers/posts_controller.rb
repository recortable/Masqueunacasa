class PostsController < ApplicationController
  respond_to :html, :atom, :xml
  before_filter :require_user, except: [:index, :show, :feed]

  expose(:themes) { current_group.site? ? 'textura03 azul_gris masq1casa' : 'textura02 naranja group' }
  expose(:posts) { current_group.posts.paginate(page: params[:page], per_page: 5).order('created_at DESC') }
  expose(:post)
  expose(:posts_archive) { Post.archive_for(current_group.posts) }

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
    respond_with post, location: root_path
  end

  def update
    flash[:notice] = t('notice.posts.updated') if post.update_attributes(params[:post])
    respond_with post
  end

  def destroy
    authorize! :delete, post
    flash[:notice] = 'Borrado' if post.destroy
    respond_with post, location: root_path
  end

  def feed
    respond_with posts    
  end
end
