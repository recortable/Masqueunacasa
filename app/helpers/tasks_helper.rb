module TasksHelper
  def render_task_list(document)
    render partial: 'tasks/list', locals: {document: document}
  end
end
