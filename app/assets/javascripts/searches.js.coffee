searches_init = ->
  form = $('#new-search-form')
  form.css('display', 'none')
  $('#new-search-link').on 'click', ->
    form.slideToggle()

$(document).ready(searches_init)
$(window).bind('page:load', searches_init)

