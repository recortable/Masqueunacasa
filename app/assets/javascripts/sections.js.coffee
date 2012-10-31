show_type_of_section_buttons = (btn) ->
  btn.fadeOut 300, ->
    btn.siblings('.add_fields').css({ opacity: 0, display: 'inline-block' }).animate
      opacity: 1
    , 300

show_add_section_btn = (btn) ->
  btn.fadeOut(300).siblings('.add_fields').fadeOut 300, ->
    btn.siblings('a.add-section').css({ opacity : 0, display: 'inline-block' }).animate
      opacity: 1
    , 300

clone_buttons = (btn) ->
  buttons = btn.closest('div.add-section').clone()
  buttons.find('a.add-section').css('display', 'inline-block').siblings('.add_fields').css('display', 'none')
  buttons.css('display', 'none')

create_hidden_content = (btn, regexp, time) ->
  $(btn.data('fields').replace(regexp, time)).css('display', 'none')

insert_and_show_content = (btn, links, content) ->
  btn.closest('div.add-section').after(links).after(content)
  content.slideDown 500, ->
    links.slideDown 150

init = ->
  # When clicking on 'Añadir una sección'
  $('form fieldset.sections-fields').on 'click', 'a.add-section', (event) ->
    show_type_of_section_buttons($(this))
    event.preventDefault()

  # When adding a text or image section
  $('form').on 'click', '.add_fields', (event) ->
    show_add_section_btn($(this))

    links = clone_buttons($(this))
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    content = create_hidden_content($(this), regexp, time)

    insert_and_show_content $(this), links, content
    event.preventDefault()

  # When removing a section
  $('form').on 'click', 'a.rm-section', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('.fields').slideUp().next('.add-section').slideUp()
    event.preventDefault()

  # Before sending the form we assingn positions
  $('html.editions.edit form').submit (event) ->
    fields = $(this).find('.fields')
    fields.each (index) ->
      $(this).find('input[id$="position"]').attr('value', index + 1)

  # Section up
  $('html.editions.edit form').on 'click',  'a.section-up', (event) ->
    fields =  $(this).closest('.fields')
    buttons = fields.next('div.add-section')
    target = fields.prevAll('.fields').first()
    if target.size() > 0
      buttons.remove()
      fields.remove()
      target.before(fields).before(buttons)
    event.preventDefault()

  # Section down
  $('html.editions.edit form').on 'click',  'a.section-down', (event) ->
    fields =  $(this).closest('.fields')
    buttons = fields.next('div.add-section')
    target = fields.nextAll('.fields').first()
    if target.size() > 0
      buttons.remove()
      fields.remove()
      target.after(fields).after(buttons)
    event.preventDefault()

$(document).ready(init)
$(window).bind('page:change', init)

