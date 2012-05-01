class PostsController < ApplicationController
  respond_to :html
  before_filter :load_subdomain_group

  expose(:posts) { group.posts }
  expose(:post)

  def index
    respond_with posts
  end

end
