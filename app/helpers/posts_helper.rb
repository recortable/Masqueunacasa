module PostsHelper
  def url_for_post(post)
    if post.group.subdomain?
      post_url(post, subdomain: post.group.subdomain)
    else
      post_url(post)
    end
  end
  def render_posts_archive(posts, group = nil)
    render partial: 'posts/archive', locals: 
      {posts: posts, group: group}
  end

  def render_post_media(post)
    render partial: 'posts/media', locals: {post: post}
  end
end
