module LinksHelper
  def render_links_bar(document)
    render partial: 'links/bar', locals: {document: document}
  end
end
