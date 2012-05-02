# encoding: utf-8
class Site
  attr_reader :name, :description

  def id
    nil
  end

  def site?
    true
  end

  def banner_image?
    false
  end

  def latest_groups
    Group.scoped.limit(10)
  end

  def posts
    Post.scoped
  end
  
  def users
    User.scoped
  end
end
