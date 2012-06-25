module GroupsHelper
  def render_group_sections
    render partial: 'groups/sections'
  end

  def group_card(group, &block)
    info = capture(&block) if block_given?
    render partial: 'groups/group', locals: {group: group, info: info}
  end

  def group_header(title)
    title(title)
    render 'groups/header'
  end

end
