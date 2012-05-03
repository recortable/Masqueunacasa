module ApplicationHelper
  def title(title, tag = :h1)
    content_for(:title) { title }
    content_tag(tag, title)
  end

  def controller_class
    controller.class.name[0..-11].downcase.gsub(/:/, '-')
  end
  
  def subdomain_class
    request.subdomain.present? ? 'subdomain' : 'main_domain'
  end

  def render_banner(title, path)
    render partial: 'application/banner', locals: 
      {title: title, path: path}
  end
end
