formsInit = ->
  form = $('form.edit_category, form.new_category, form.edit_proposal, form.new_proposal,
    form.edit_experiencie, form.new_experiencie, form.edit_help_page, form.new_help_page')

  if form.length
    container = $('.sidebar.left .fixed-block .controls')
    button_text = form.find('input[type="submit"]').hide().attr('value')
    new_button = $('<button class="btn btn-block">' + button_text + ' <i class="icon-save"></i></button>')
    container.prepend new_button
    new_button.on 'click', ->
      form.submit()

$(document).ready(formsInit);
$(window).bind('page:load', formsInit);

