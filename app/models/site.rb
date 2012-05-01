# encoding: utf-8
class Site
  def posts
    Post.scoped
  end
end
