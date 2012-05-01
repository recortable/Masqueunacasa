module ApplicationHelper
  def title(title, tag = :h1)
    content_for(:title) { title }
    content_tag(tag, title)
  end

  def controller_class
    controller.class.name[0..-11].downcase.gsub(/:/, '-')
  end
end
