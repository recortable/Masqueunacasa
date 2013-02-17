module HasBreadcrumbs
  extend ActiveSupport::Concern

  protected

  # HABITAPEDIA
  def breadcrumb_for_root
    add_breadcrumb 'Mas que una casa', root_path
  end

  def polymorphic_breadcrumb_for(document)
    name = document.class.name.downcase
    self.send("breadcrumb_for_#{name}", document)
  end

  def breadcrumb_for_habitapedia
    @active_tab ||= "habitapedia"
    add_breadcrumb 'Habitapedia', phases_path
  end

  def breadcrumb_for_phase(phase)
    breadcrumb_for_habitapedia
    add_breadcrumb phase.title, phases_path(anchor: 'fases')
  end

  def breadcrumb_for_category(category)
    breadcrumb_for_phase(category.phase)
    add_breadcrumb category.title, phase_category_path(category.phase, category)
  end

  def breadcrumb_for_proposal(proposal)
    breadcrumb_for_category(proposal.category)
    add_breadcrumb proposal.title, proposal_path(proposal)
  end

  def breadcrumb_for_experiencies
    @active_tab = "experiencies"
    breadcrumb_for_habitapedia
    add_breadcrumb 'Experiencias', :experiencies_path
  end

  def breadcrumb_for_experiencie(experiencie)
    breadcrumb_for_experiencies
    add_breadcrumb experiencie.title, experiencie_path(experiencie)
  end

  def breadcrumb_for_community
    @active_tab = 'community'
    add_breadcrumb 'Comunidad', community_url(subdomain: false)
  end

  def breadcrumb_for_users
    add_breadcrumb 'Participantes', users_path
  end

  def breadcrumb_for_user(user)
    breadcrumb_for_users
    add_breadcrumb user.name, user_url(user, subdomain: false)
  end

  def breadcrumb_for_group(group)
    breadcrumb_for_community
    add_breadcrumb group.title, profile_url(subdomain: group.subdomain)
  end

  def breadcrumb_for_posts(group)
    breadcrumb_for_group group
    add_breadcrumb 'Blog', posts_url(subdomain: group.subdomain)
  end

  def breadcrumb_for_post(post)
    breadcrumb_for_posts post.group
    add_breadcrumb post.title, post_url(post, subdomain: post.group.subdomain)
  end
end
