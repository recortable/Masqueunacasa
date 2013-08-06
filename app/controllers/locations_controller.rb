# encoding: utf-8
class LocationsController  < ApplicationController
  respond_to :html
  expose(:locations) { Location.all }

  def index
    @json4map = locations.to_gmaps4rails do |location, marker|
      marker.json({ id: location.id })
      marker.title location.resource.title
      marker.infowindow location.resource.title
    end
  end
end

