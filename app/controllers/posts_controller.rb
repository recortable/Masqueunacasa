class PostsController < ApplicationController
  respond_to :html
  before_filter :group_or_site_from_subdomain

  expose(:posts) { group.posts }
  expose(:post)

  def index
    respond_with posts
  end

end
