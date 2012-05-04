module GroupsHelper
  def group_header(title)
    render 'groups/header'
  end

  def group_avatar(group)
    group.avatar_image? ? image_tag(group.avatar_image_url, alt: group.name) :
      placeholder_image_tag(text: '', width: 120, height: 120)
  end
end
