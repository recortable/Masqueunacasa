$(document).on "nested:fieldAdded", (event) ->
  event.field.parent('p').before(event.field)

init = ->

$(document).ready(init)
$(window).bind('page:change', init)

