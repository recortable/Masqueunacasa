class VersionsController < ApplicationController
  respond_to :html
  expose(:versions) { Activity.site_activity }
  expose(:version)

  def index
    respond_with versions
  end

  def show
    url = url_for_version(version)
    url.present? ? redirect_to(url) : render(text: version.inspect)
  end

  private
  def url_for_version(version)
    case version.item_type
    when 'Section'
      section = Section.find version.item_id
      url_for(section.document, anchor: section.to_anchor)
    else
      klass = version.item_type.constantize
      model = klass.find version.item_id
      url_for(model)
    end
  end
end
