# encoding: utf-8
class Site
  attr_reader :name, :description

  def id
    nil
  end

  def name
    'Masqueunacasa'
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

  def phases
    Phase.order('position ASC')
  end

  def groups
    Group.order('updated_at DESC')
  end

  def latest_groups
    Group.scoped.limit(6)
  end

  def posts
    Post.scoped
  end
  
  def users
    User.order('updated_at DESC')
  end

  def versions
    Version.scoped
  end
end
