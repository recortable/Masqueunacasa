
$ ->
  $('div.locations').showMap()
  $('form.new_location').mapForForm()
  $('form.edit_location').mapForForm()

  
$.fn.extend
  showMap: ->
    return this.each ->
      locations = []
      $(this).find('.location').each ->
        lat = $(this).data('latitude')
        lon = $(this).data('longitude')
        location = new google.maps.LatLng(lat, lon)
        locations.push location

      center = new google.maps.LatLng(40.24, -3.24)

      mapOptions = 
        center: center,
        zoom: 5,
        mapTypeId: google.maps.MapTypeId.HYBRID,
        streetViewControl: false
      
      mapCanvas = $(this).find('.map')
      mapCanvas.css({'width': '100%'}).height($(this).width())
      map = new google.maps.Map(mapCanvas.get(0),
              mapOptions)

      $.each locations, ->
        new google.maps.Marker
          position: this,
          map: map

$.fn.extend
  mapForForm: ->
    return this.each ->
      center = new google.maps.LatLng(40, -3)

      mapOptions = 
        center: center,
        zoom: 5,
        mapTypeId: google.maps.MapTypeId.HYBRID,
        streetViewControl: false

      mapCanvas = $(this).find('.map')
      inputLat = $(this).find('[id*="latitude"]')
      inputLon = $(this).find('[id*="longitude"]')
      lat = inputLat.val()
      lon = inputLon.val()

      mapCanvas.css({'width': '100%', 'height': '300px'});
      # TODO: repasar esto!
      #inputLat.attr('disabled', 'disabled')
      #inputLon.attr('disabled', 'disabled')

      map = new google.maps.Map(mapCanvas.get(0),
             mapOptions);

      marker = new google.maps.Marker
        map: map      

      if lat and lon
        position = new google.maps.LatLng(lat, lon)
        marker.setPosition(position)

      google.maps.event.addListener map, 'click', (event) ->
        position = event.latLng.toUrlValue().split(",");
        inputLat.val(position[0])
        inputLon.val(position[1])
        marker.setPosition(event.latLng)
