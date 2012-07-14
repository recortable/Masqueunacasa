
$ ->
  $('.locations').showMap()
  $('form.new_location').mapForForm()

  
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
        mapTypeId: google.maps.MapTypeId.HYBRID
      
      mapCanvas = $(this).find('.map')
      mapCanvas.css({'width': '100%', 'height': '300px'});
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
        mapTypeId: google.maps.MapTypeId.HYBRID

      mapCanvas = $(this).find('.map')
      map = new google.maps.Map(mapCanvas.get(0),
             mapOptions);

      google.maps.event.addListener map, 'click', (event) ->
        position = event.latLng.toUrlValue().split(",");

        $('[id*="latitude"]').val(position[0])
        $('[id*="longitude"]').val(position[1])

        marker = new google.maps.Marker
          map: map
          position: event.latLng
