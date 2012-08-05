module EditorshipsHelper
  def render_editorships_list(document)
    render partial: 'editorships/list', locals: { document: document }
  end
end
