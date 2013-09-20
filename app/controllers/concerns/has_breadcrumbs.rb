module HasBreadcrumbs
  extend ActiveSupport::Concern

  protected

  def breadcrumb_for_habitapedia
    @active_tab = "habitapedia"
    add_breadcrumb t('application.tabs.habitapedia.text'), phases_path,
      class: "habitapedia level-#{level}"
  end

  def breadcrumb_for_phase
    breadcrumb_for_habitapedia
  end

  def breadcrumb_for_category(category)
    breadcrumb_for_phase
    add_breadcrumb category.phase.title, phase_path(category.phase),
      class: "#{category.phase.slug_es} level-#{level}"
  end

  def breadcrumb_for_proposal(proposal)
    breadcrumb_for_category(proposal.category)
    add_breadcrumb proposal.category.title,
      phase_category_path(proposal.category.phase, proposal.category),
      class: "category level-#{level}"
  end

  def breadcrumb_for_experiencies
    @active_tab = "experiencies"
  end

  def breadcrumb_for_experiencie(experiencie)
    breadcrumb_for_experiencies
    add_breadcrumb Experiencie.model_name.human(count: 2).titleize,
      experiencies_path, class: "experiencies level-#{level}"
  end

  def breadcrumb_for_community
    @active_tab = 'community'
    add_breadcrumb t('application.tabs.community'), community_url,
      class: "community level-#{level}"
  end

  def breadcrumb_for_user(user)
    breadcrumb_for_community
  end

  def breadcrumb_for_group(group)
    breadcrumb_for_community
  end

  private

  def level
    @level ||= 0
    @level +=1
  end
end

