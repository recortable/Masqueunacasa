class VersionsController < ApplicationController
  respond_to :html
  expose(:versions) { Activities.site_activity }
  expose(:version)

  def index
    respond_with versions
  end

  def show
    url = url_for_version(version)
    url.present? ? redirect_to(url) : render(action: 'not_found')
  end

  private
  def url_for_version(version)
    case version.item_type
    when 'Section'
      section = Section.find version.item_id
      document = section.document
      if document.respond_to?(:group)
        group = document.group
        polymorphic_url(document, subdomain: group.subdomain, anchor: section.to_anchor)
      else
        polymorphic_path(document, anchor: section.to_anchor)
      end
    when 'Image'
      image = Image.find version.item_id
      polymorphic_path(image.imageable)
    when 'Agent'
      group = Group.find version.item_id
      root_url(subdomain: group.subdomain)
    else
      begin
        klass = version.item_type.constantize
        model = klass.find_by_id version.item_id
        if model.respond_to?(:document)
          url_for(model.document)
        elsif model.present?
          if model.respond_to?(:group)
            polymorphic_url(model, subdomain: model.group.subdomain)
          else
            polymorphic_path(model)
          end
        else
          nil
        end
      rescue
        nil  
      end
    end
  end
end
