# encoding: utf-8
class Site
  def posts
    Post.scoped
  end
  
  def users
    User.scoped
  end
end
