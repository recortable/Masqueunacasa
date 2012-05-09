module GroupsHelper
  def group_card(group, &block)
    info = capture(&block) if block_given?
    render partial: 'groups/group', locals: {group: group, info: info}
  end

  def group_header(title)
    title(title)
    render 'groups/header'
  end

end
