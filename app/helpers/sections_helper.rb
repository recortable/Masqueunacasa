module SectionsHelper
  def render_sections(document)
    render partial: 'sections/index', locals: {document: document}
  end

  def render_sections_summary(document)
    render partial: 'sections/summary', locals: {document: document}
  end
end
