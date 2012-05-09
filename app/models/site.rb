# encoding: utf-8
class Site
  attr_reader :name, :description

  def id
    nil
  end

  def site?
    true
  end

  def membership_for(user) 
    nil
  end

  def banner_image?
    false
  end

  def latest_groups
    Group.scoped.limit(6)
  end

  def posts
    Post.scoped
  end
  
  def users
    User.scoped
  end
end
