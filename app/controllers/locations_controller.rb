# encoding: utf-8
class LocationsController  < ApplicationController
  respond_to :html
  expose(:locations) { Location.all }

  def index
    breadcrumb_for_locations
    @json4map = locations.to_gmaps4rails do |location, marker|
      marker.json({ id: location.id, type: location.resource.class.to_s.downcase })
      marker.title location.resource.title
      marker.infowindow render_to_string( partial: 'map_infowindow',
                                         locals: { location: location } )
      marker.picture view_context.marker_picture(location)
    end
    respond_with locations
  end
end

