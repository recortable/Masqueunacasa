module LocationsHelper
  def render_locations_bar(resource)
    render partial: 'locations/bar', locals: { resource: resource}
  end

  def google_maps
    content_for :head do
      url = "http://maps.googleapis.com/maps/api/js?sensor=false&language=#{I18n.locale}&region=ES"
      raw "<script type='text/javascript' src='#{url}'></script>"
    end
  end
end
