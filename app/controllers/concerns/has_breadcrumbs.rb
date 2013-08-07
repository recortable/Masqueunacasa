module HasBreadcrumbs
  extend ActiveSupport::Concern

  protected

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
    add_breadcrumb 'Comunidad', community_url
  end

  def breadcrumb_for_users
    breadcrumb_for_community
    add_breadcrumb 'Participantes', users_path
  end

  def breadcrumb_for_user(user)
    breadcrumb_for_users
    add_breadcrumb user.name, user_url(user, subdomain: false)
  end

  def breadcrumb_for_group(group)
    breadcrumb_for_community
    add_breadcrumb group.title, group_path(group)
  end

  def breadcrumb_for_admin_area
    @active_tab = 'admin'
    add_breadcrumb 'Admin area', admin_area_path
  end

  def breadcrumb_for_locations
    @active_tab = 'map'
    add_breadcrumb t('routes.locations'), locations_path
  end
end
