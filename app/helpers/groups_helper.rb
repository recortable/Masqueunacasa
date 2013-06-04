module GroupsHelper
  def render_group_sections(group = nil)
    group ||= current_group
    render partial: 'groups/sections', locals: {group: group}
  end

  def group_card(group, &block)
    info = capture(&block) if block_given?
    render partial: 'groups/group', locals: {group: group, info: info}
  end
end
