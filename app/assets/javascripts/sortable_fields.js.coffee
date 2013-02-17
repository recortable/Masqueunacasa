# Set the position before submit the form. Make fields sortable
init = ->
  $('.sortable_fieldset').closest('form').on('submit', ->
    fields = $(this).find('.fields')
    fields.each (index) ->
      $(this).find('input[id$="position"]').attr('value', index + 1)
  ).sortable
    axis: 'y'
    dropOnEmpty: false
    handle: '.handle'
    items: 'div.fields'
    opacity: 0.4
    scroll: true
    containment: 'parent'

$(document).ready(init)
$(window).bind('page:change', init)
