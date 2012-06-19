module TextHelper
  def render_body(model) 
    return '' if model.blank?
    content_tag(:div, render_text(model.body, model.body_type), class: "body #{model.body_type}")
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
