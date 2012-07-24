
options = (center, zoom) ->
  mapOptions =
    center: center,
    zoom: zoom,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    streetViewControl: false

extractLocations = (divs) ->
  locations = []
  divs.each ->
    lat = $(this).data('latitude')
    lon = $(this).data('longitude')
    location = new google.maps.LatLng(lat, lon)
    locations.push location
  locations

createMap = (container, center, zoom = 5) ->
  mapCanvas = container
  mapCanvas.css({'width': '100%'}).height(mapCanvas.width())
  map = new google.maps.Map(mapCanvas.get(0),
          options(center, zoom))

$.fn.extend
  showMap: ->
    return this.each ->
      locations = extractLocations $(this).find('.location')

      center = locations[0]
      zoom = 14

      map = createMap $(this).find('.map'), center, zoom

      $.each locations, ->
        new google.maps.Marker
          position: this,
          map: map
          
      if locations.length > 1
        bounds = new google.maps.LatLngBounds
        bounds.extend location for location in locations

      map.fitBounds bounds if bounds

$.fn.extend
  mapForForm: ->
    return this.each ->
      center = new google.maps.LatLng(40, -3)
      map = createMap $(this).find('.map'), center

      inputLat = $(this).find('[id*="latitude"]')
      inputLon = $(this).find('[id*="longitude"]')
      lat = inputLat.val()
      lon = inputLon.val()

      #inputLat.attr('disabled', 'disabled')
      #inputLon.attr('disabled', 'disabled')

      #$(this).submit =>
        #inputLat.removeAttr('disabled')
        #inputLon.removeAttr('disabled')

      marker = new google.maps.Marker
        map: map

      if lat and lon
        position = new google.maps.LatLng(lat, lon)
        marker.setPosition(position)

      google.maps.event.addListener map, 'click', (event) ->
        position = event.latLng.toUrlValue().split(",")
        inputLat.val(position[0])
        inputLon.val(position[1])
        marker.setPosition(event.latLng)
