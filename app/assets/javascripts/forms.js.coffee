formsInit = ->
  form = $('form.edit_category, form.new_category, form.edit_proposal, form.new_proposal,
    form.edit_experiencie, form.new_experiencie, form.edit_help_page, form.new_help_page')

  if form.length
    container = $('.sidebar.left .fixed-block')
    button_text = form.find('input[type="submit"]').attr('value')
    new_button = $('<button class="btn pull-right">' + button_text + '</button>')
    container.append new_button
    new_button.on 'click', ->
      form.submit()

$(document).ready(formsInit);
$(window).bind('page:load', formsInit);

