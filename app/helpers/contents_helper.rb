module ContentsHelper 
  def markdown(text)
    markdowner.render(text).html_safe
  end

  def markdowner
    @markdown ||= Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      hard_wrap: true, autolink: true,
      fenced_code_blocks: true)
  end
end
