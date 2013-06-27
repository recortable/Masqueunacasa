//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-dropdown
// turbolinks
//= require jquery.foundation.orbit
//= require slider
//= require maps
//= require mediafy
//= require experiencies
//= require galleria/galleria-1.2.9.min
//= require galleria/galleria.classic.min
//= require jquery_nested_form
//= require sections
//= require categories
//= require sortable_fields
//# require ckeditor/init
//= require utils
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
  $('div.locations').showMap();
  $('fieldset.locations').mapForForm();
  if ($('.galleria').length > 0) {
    Galleria.run('.galleria');
  }
  $('.slider').applySlider();
  $('.body a').mediafy();

  $('form img').image_cache_src(); // Defined in utils.js

  // http://twitter.github.io/bootstrap/javascript.html#affix
  // usado en columna de la izquierda
  var fixed = $('#sidebar-left .fixed-block')
  var offsetFn = function() {
    return fixed.parent().offset().top
  };
  fixed.affix( {offset: {top: offsetFn} } );
};

$(document).ready(MqucInit);
$(window).bind('page:load', MqucInit);

