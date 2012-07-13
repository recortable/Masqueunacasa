module GroupsHelper
  def gurl_for(group)
    root_url(subdomain: group.slug)
  end

  # TODO: borrar este método
  def url_for_membership(group, membership)
    membership_url(membership, subdomain: group.slug)
  end

  def render_group_bar(group)
    render partial: 'groups/bar', locals: {group: group}
  end

  def render_group_sections(group = nil)
    group ||= current_group
    render partial: 'groups/sections', locals: {group: group}
  end

  def group_card(group, &block)
    info = capture(&block) if block_given?
    render partial: 'groups/group', locals: {group: group, info: info}
  end

  def group_header(title, group = nil)
    group ||= current_group
    render partial: 'groups/header', locals: {group: group }
  end

  def render_group_header(group)
    render partial: 'groups/header', locals: {group: group }
  end

end
