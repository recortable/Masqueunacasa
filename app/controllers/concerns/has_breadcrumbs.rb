module HasBreadcrumbs
  extend ActiveSupport::Concern

  protected
  def breadcrumb_for_root
    add_breadcrumb 'Mas que una casa', root_path
  end

  def breadcrumb_for_habitapedia
    breadcrumb_for_root
    add_breadcrumb 'Habitapedia', phases_path
  end

  def breadcrumb_for_phase(phase)
    breadcrumb_for_habitapedia
    add_breadcrumb phase.title, phase_path(phase)
  end

  def breadcrumb_for_category(category)
    breadcrumb_for_phase(category.phase)
    add_breadcrumb category.question, phase_category_path(category.phase, category)
  end

  def breadcrumb_for_proposal(proposal)
    breadcrumb_for_category(proposal.category)
    add_breadcrumb proposal.title, proposal_path(proposal)
  end

  def breadcrumb_for_experiencies
    breadcrumb_for_habitapedia
    add_breadcrumb 'Experiencias', :experiencies_path
  end

  def breadcrumb_for_experiencie(experiencie)
    breadcrumb_for_experiencies
    add_breadcrumb experiencie.title, experiencie_path(experiencie)
  end

end
