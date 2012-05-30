$(function(){
  initialize(null);

  navigator.geolocation.getCurrentPosition(initialize);

});

function with_localization(position) {
  initialize(lat, lng, zoom);
}

function initialize(position) {
  $('#map_canvas').css({'width': '90%', 'height': '200px'});
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
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById("map_canvas"),
            myOptions);
}