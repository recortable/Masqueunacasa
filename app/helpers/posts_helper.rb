module PostsHelper
  def render_posts_archive(posts, group = nil)
    render partial: 'posts/archive', locals: 
      {posts: posts, group: group}
  end

  def render_post_media(post)
    render partial: 'posts/media', locals: {post: post}
  end
end
