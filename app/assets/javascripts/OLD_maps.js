$(function(){
  maps();
});

function maps() {
  if ($('#form_map').length != 0) {
    var dataLoc = $('#form_map').attr('data-location');
    if (dataLoc) {
      var position = dataLoc.split(",")
      init_map_for_form(position[0], position[1], true)
    } else {
      /* 
       * Se llama dos veces la función initialize(), una al cargar la página
       * i otra de nuevo si el usuario acepta compartir su ubicación.
       * Un bug en firefox hace que no funcione 
       * getCurrentPosition(onSuccessFunction, onErrorFunction)
       */
      init_map_for_form(null, null, false);
      navigator.geolocation.getCurrentPosition(pre_init_map_for_form);
    }
  }

  if ($('#show_map').length != 0) {
    init_map();
  }  
}

function pre_init_map_for_form(position) {
  var lat = position.coords.latitude;
  var lng = position.coords.longitude;

  init_map_for_form(lat, lng, false);
}

var map_for_form;
var marker_for_form;

/*
 * Doble click deshabilitado, si se autoriza compartir localización 
 * se usa esta para el centro, si no se centra a la península
 */
function init_map_for_form(lt, lg, with_marker) {
  /* Anchura del mapa adaptativa */
  $('#form_map').css({'width': '100%', 'height': '275px'});
  
  if (lt && lg) {
    var lat = lt;
    var lng = lg;
    var zm = 12;
  } else {
    var lat = 40;
    var lng = -3;
    var zm = 5;    
  }
  var position = new google.maps.LatLng(lat, lng);


  var myOptions = {
    center: position,
    zoom: zm,
    mapTypeId: google.maps.MapTypeId.HYBRID, 
    disableDoubleClickZoom: true
  };

  map_for_form = new google.maps.Map(document.getElementById("form_map"),
            myOptions);
  marker_for_form = new google.maps.Marker({
    map: map_for_form
  });

  /*
   * Si la posición estaba definida ponemos marcador y establecemos 
   * values para inputs latitude y longitude 
   */
  if (with_marker) { setLocation(position); }

  google.maps.event.addListener(map_for_form, 'click', function(event) {
    setLocation(event.latLng);
  });
}

function setLocation(location) {
  marker_for_form.setPosition(location);
  var position = location.toUrlValue().split(",");

  $('[id*="latitude"]').val(position[0])
  $('[id*="longitude"]').val(position[1])
}

function init_map() {
  /* Anchura del mapa adaptativa */
  $('#show_map').css({'width': '100%', 'height': '300px'});

  var coord = $('#show_map').attr('data-location').split(",")
  var lat = coord[0];
  var lng = coord[1];
  zm = 12;
  var location = new google.maps.LatLng(lat, lng);

  var myOptions = {
    center: location,
    zoom: zm,
    mapTypeId: google.maps.MapTypeId.HYBRID
  };

  var map = new google.maps.Map(document.getElementById("show_map"),
            myOptions);

  var marker = new google.maps.Marker({
    position: location,
    map: map_for_form
  });

  new google.maps.Marker({
    position: location,
    map: map
  });
}