module TextHelper
  def render_body(model)
    return '' if model.blank?
    body_type = model.respond_to?('body_type') ? model.body_type : 'markdown'
    content_tag(:div, render_text(model.body, body_type), class: "body #{body_type}")
  end

  def render_text(content, type) 
    type == 'html' ? raw(content) : markdown(content)
  end

  def markdown(text)
    return '' unless text.present?
    text.gsub! /^#+/, '### '
    markdowner.render(text).html_safe
  end

  def markdowner
    @markdown ||= Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      hard_wrap: true, autolink: true,
      fenced_code_blocks: true)
  end
end
