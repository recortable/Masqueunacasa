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
    Group.where('id <> 1').limit(6)
  end

  def posts
    Post.scoped
  end

  def latest_posts(page = 1, per_page = 5)
    Post.paginate(page: page, per_page: per_page).order('created_at DESC')
  end
  
  def users
    User.order('updated_at DESC')
  end

  def versions
    Version.scoped
  end
end
