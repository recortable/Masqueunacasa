//= require jquery
//= require jquery.ui.sortable
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
  $('form.new_location').mapForForm();
  $('form.edit_location').mapForForm();
  if ($('.galleria').length > 0) {
    Galleria.run('.galleria');
  }
  $('.slider').applySlider();
  $('.body a').mediafy();

  $('form img').image_cache_src(); // Defined in utils.js
};

$(document).ready(MqucInit);
$(window).bind('page:load', MqucInit);

