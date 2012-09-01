class PostsController < ApplicationController
  respond_to :html, :atom, :xml
  before_filter :require_user, except: [:index, :show, :feed]
  before_filter :require_admin, only: [:dashboard]

  expose(:themes) { current_group.site? ? 'textura03 azul_gris masq1casa' : 'textura02 naranja group' }

  expose(:posts) { current_group.posts }
  expose(:post)
  expose(:post_list) { current_group.posts.paginate(page: params[:page], per_page: 5).order('created_at DESC').includes(:user) }
  expose(:archive_posts) { current_group.posts }

  expose(:all_posts) { Post.reorder('updated_at DESC') }

  expose(:with_banner) { true }

  def dashboard
    respond_with all_posts
  end

  def index
    breadcrumb_for_posts current_group
    respond_with posts
  end

  def show
    authorize! :read, post
    post.increment_view_counter
    breadcrumb_for_post(post)
    respond_with post
  end

  def new
    authorize! :new, Post
  end

  def edit
    authorize! :update, Post
    breadcrumb_for_post(post)
    add_breadcrumb 'Editar', edit_post_path(post)
    respond_with post
  end

  def create
    post.user = current_user
    post.group = current_group
    authorize! :create, post
    flash[:notice] = t('posts.notices.created') if post.save
    respond_with post
  end

  def update
    flash[:notice] = t('posts.notices.updated') if post.update_attributes(params[:post])
    respond_with post
  end

  def destroy
    authorize! :delete, post
    flash[:notice] = t('posts.notices.destroyed') if post.destroy
    respond_with post, location: posts_path
  end

  def feed
    respond_with posts
  end
end
