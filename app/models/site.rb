# encoding: utf-8
class Site
  attr_reader :name, :description
  attr_reader :name?, :description?

  def posts
    Post.scoped
  end
  
  def users
    User.scoped
  end
end
