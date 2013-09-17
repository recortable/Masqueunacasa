//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-dropdown
//= require bootstrap-tooltip
// turbolinks
//= require slider
//= require mediafy
//= require galleria/galleria-1.2.9.min
//= require galleria/galleria.classic.min
//= require jquery_nested_form
//= require sections
//= require categories
//= require sortable_fields
//= require imagesloaded.min
//= require resize_images
//= require utils
//= require markitup
//= require markitup_settings
//= require forms
//= require gmaps4rails/gmaps4rails.base
//= require gmaps4rails/gmaps4rails.googlemaps
//= require_self

Galleria.configure({
  transition: 'pulse',
  lightbox: false,
  overlayBackground: '#e0e0e0',
  transitionSpeed: 400,
  showCounter: false,
  responsive: true,
  easing: 'swing',
  autoplay: 7000,
  showInfo: true
});

var MqucInit = function() {
  if ($('.galleria').length > 0) {
    Galleria.run('.galleria');
  }
  $('body a').mediafy();

  $('form img').image_cache_src(); // Defined in utils.js

  // http://twitter.github.io/bootstrap/javascript.html#affix
  // usado en columna de la izquierda
  var fixed = $('.fixed-block')
  var offsetFn = function() {
    return fixed.parent().offset().top
  };
  fixed.affix( {offset: {top: offsetFn} } );

  $('textarea.rte').markItUp(myMarkItUpSettings);
  $('span.with-tooltip').tooltip();
};

$(document).ready(MqucInit);
$(window).bind('page:load', MqucInit);

