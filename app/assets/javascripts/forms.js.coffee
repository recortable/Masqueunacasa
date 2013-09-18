formsInit = ->
  $('form .select2').each ->
    select = $(this)
    placeholder = select.data('placeholder')
    select.select2({placeholder: placeholder})

  form = $('form.edit_category, form.new_category, form.edit_proposal, form.new_proposal,
    form.edit_experiencie, form.new_experiencie, form.edit_help_page, form.new_help_page')

  if form.length
    original_button = form.find('input[type="submit"]')
    button_text = original_button.attr("value")
    original_button.hide()

    sidebar_container = $('.sidebar.left .fixed-block .controls')
    form_container = original_button.parent()

    new_button_at_left = $('<button class="btn btn-block" id="commit-form-left">' + button_text + ' <i class="icon-save"></i></button>')
    new_button = $('<button class="btn btn-block" id="commit-form">' + button_text + ' <i class="icon-save"></i></button>')

    sidebar_container.prepend new_button_at_left
    form_container.append new_button

    $.each [new_button, new_button_at_left], (index, elem) ->
      elem.on 'click', ->
        form.submit()

$(document).ready(formsInit)
$(window).bind('page:load', formsInit)

