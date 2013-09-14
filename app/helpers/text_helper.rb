module TextHelper
  def markdown(text)
    return '' unless text.present?
    text.gsub!(/^#+/, '### ')
    text.gsub!(/\(::(.+)::\)/) do
      "(#{url_internal($1)})"
    end
    markdowner.render(text).html_safe
  end

  def markdowner
    @markdown ||= Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new(hard_wrap: true),
      autolink: true,
      fenced_code_blocks: true)
  end

private

  def url_internal(code)
    kontroller, id = code.split('::')
    if id
      url_for kontroller.classify.constantize.find(id)
    else
      url_for controller: kontroller, action: 'index'
    end
  end
end
