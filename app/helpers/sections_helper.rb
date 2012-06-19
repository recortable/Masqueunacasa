module SectionsHelper
  def render_sections(document)
    render partial: 'sections/index', locals: {document: document}
  end
end
