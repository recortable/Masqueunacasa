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
      polymorphic_path(section.document, anchor: section.to_anchor)
    else
      klass = version.item_type.constantize
      model = klass.find_by_id version.item_id
      model.present? ? url_for(model) : nil
    end
  end
end
