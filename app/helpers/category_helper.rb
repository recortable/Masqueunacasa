module CategoryHelper
  def render_category_list(phase, options = {})
    options.reverse_merge! title: 'Preguntas'
    render partial: 'categories/list', 
      locals: { phase: phase, options: options }
  end
end
