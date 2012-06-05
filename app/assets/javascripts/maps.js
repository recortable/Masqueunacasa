$(function(){

  /* 
   * Se llama dos veces la función initialize(), una al cargar la página
   * i otra de nuevo si el usuario acepta compartir su ubicación.
   * Un bug en firefox hace que no funcione 
   * getCurrentPosition(onSuccessFunction, onErrorFunction)
   */
  initialize(null);
  navigator.geolocation.getCurrentPosition(initialize);

});

function with_localization(position) {
  initialize(lat, lng, zoom);
}

var map;
var marker;

function initialize(position) {
  $('#group_form_map').css({'width': '100%', 'height': '275px'});
  if (position) {
    var lat = position.coords.latitude;
    var lng = position.coords.longitude;
    var zm = 15;
  } else {
    var lat = 40;
    var lng = -3;
    var zm = 4;    
  }
  var myOptions = {
    center: new google.maps.LatLng(lat, lng),
    zoom: zm,
    mapTypeId: google.maps.MapTypeId.ROADMAP, 
    disableDoubleClickZoom: true
  };

  map = new google.maps.Map(document.getElementById("group_form_map"),
            myOptions);
  marker = new google.maps.Marker({
    map: map
  });

  google.maps.event.addListener(map, 'click', function(event) {
    setLocation(event.latLng);
  });
}

function setLocation(location) {
  marker.setPosition(location);

  var position = location.toUrlValue().split(",");
  $('#group_latitude').val(position[0])
  $('#group_longitude').val(position[1])
}