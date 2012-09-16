module ApplicationHelper
  def title(title, tag = :h1)
    content_for(:title) { title }
    content_tag(tag, title)
  end

  def controller_class
    controller.class.name[0..-11].downcase.gsub(/:/, '-') + " " + controller.action_name
  end

  def subdomain_class
    request.subdomain.present? ? 'subdomain' : 'main_domain'
  end

  def current_user_admin?
    current_user && current_user.admin?
  end

  # Translate collection
  # Used in forms (see views/memberships/edit)
  def tc(prefix, collection)
    collection.map {|item| [I18n.t("#{prefix}.#{item}"), item] }
  end

  def render_banner(title, path)
    render partial: 'application/banner', locals: 
      {title: title, path: path}
  end

  def render_card(&block)
    content = block_given? ? capture(&block) : ''
    render partial: 'application/card', locals: {content: content}
  end

  def render_editor(document)
    render partial: 'application/editor', locals: { document: document }
  end

  def hover?(action, subject, &block)
    if can? action, subject
      content_tag(:div, capture(&block), class: 'hover')
    else
      ''
    end
  end

  def simple_list(collection, options = {}, &block)
    options.reverse_merge! class: ''
    content = "<table class='table #{options[:class]}'>"
    collection.each do |item|
      content += "<tr><td>#{capture(item, &block)}</td></tr>"
    end
    content += '</table>'
    raw content
  end

  def icon(icon, label = nil)
    label = label.present? ? h(" #{label}") : ''
    raw("<i class='icon-#{icon}'></i>#{label}")
  end

  def simple_debug(model)
    debug(model) if Rails.env.development?
  end

  def front?
    controller.controller_name == "dashboard" && controller.action_name == "welcome"
  end

  def link_to_add_fields(name, f, association, type)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(type.to_s + "_" + association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "btn add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
end
