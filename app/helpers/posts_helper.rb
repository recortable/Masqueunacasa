module PostsHelper
  def render_post_media(post)
    render partial: 'posts/media', locals: {post: post}
  end
end
