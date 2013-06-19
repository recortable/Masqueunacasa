# Set the position before submit the form. Make fields sortable
init = ->
  $('.sortable_fieldset').on 'click', '.sort-fields a', (event) ->
    self = $(this)
    fields = self.closest('div.fields')
    fields.insertBefore fields.prev('.fields') if self.hasClass('up')
    fields.insertAfter fields.next('.fields') if self.hasClass('down')
  .closest('form').on 'submit', ->
    fieldset = $(this).find('.sortable_fieldset')
    fieldset.each ->
      fields = $(this).find('.fields')
      fields.each (index) ->
        $(this).find('input[id$="position"]').attr('value', index + 1)

$(document).ready(init)
$(window).bind('page:change', init)
