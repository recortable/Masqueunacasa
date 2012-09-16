module SectionsHelper
  def render_sections(document)
    render partial: 'sections/index', locals: {document: document}
  end

  def render_sections_summary(document)
    render partial: 'sections/summary', locals: {document: document}
  end

  def render_section_fields(form_builder)
   if form_builder.object.body?
     render 'text_section_fields', f: form_builder
   elsif form_builder.object.image?
     render 'image_section_fields', f: form_builder
   end
  end
end
