module MembershipsHelper
  def render_memberships_list(group)
    render partial: 'memberships/list', locals: {group: group}
  end
end
