module GroupsHelper
  def group_card(group, &block)
    info = capture(&block) if block_given?
    render partial: 'groups/group', locals: {group: group, info: info}
  end

  def group_header(title)
    title(title)
    render 'groups/header'
  end

  def group_avatar(group)
    group.avatar_image? ? image_tag(group.avatar_image_url, alt: group.name, class: 'responsive') :
      placeholder_image_tag(text: '', width: 120, height: 120, class: 'responsive')
  end
end
