//= require jquery
//= require jquery_ujs
//= require bootstrap-dropdown
//= require bootstrap-tooltip
//= require bootstrap-alert
//= require jquery.stickem
// turbolinks
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
//= require select2
//= require searches
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
  showInfo: true,
  debug: false
});

var MqucInit = function() {
  if ($('.galleria').length > 0) {
    Galleria.run('.galleria');
  }

  $("div.no-mediafy a").addClass("no-mediafy")
  $("body a:not(.no-mediafy)").mediafy();

  $('form img').image_cache_src(); // Defined in utils.js

  $('textarea.rte').markItUp(myMarkItUpSettings);
  $('span.with-tooltip').tooltip();

  $('#sidebar-left').stickem({
    item: '.fixed-block',
    container: '#content',
    stickClass: 'affix',
    endStickClass: 'affix-bottom'
  });
};

$(document).ready(MqucInit);
$(window).bind('page:load', MqucInit);

