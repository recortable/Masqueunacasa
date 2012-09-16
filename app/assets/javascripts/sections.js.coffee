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
  btn.closest('div.add-section').clone()

create_hidden_content = (btn, regexp, time) ->
  $(btn.data('fields').replace(regexp, time)).css('display', 'none')

insert_and_show_content = (btn, links, content) ->
  btn.closest('div.add-section').after(links).after(content)
  content.slideDown 500

jQuery ->
  # When clicking on 'Añadir una sección'
  $('form fieldset.sections-fields').on 'click', 'a.add-section', (event) ->
    show_type_of_section_buttons($(this))
    event.preventDefault()

  # When adding a text or image section
  $('form').on 'click', '.add_fields', (event) ->
    links = clone_buttons($(this))
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    content = create_hidden_content($(this), regexp, time)

    show_add_section_btn($(this))

    insert_and_show_content $(this), links, content
    event.preventDefault()

  $('form').on 'click', 'a.rm-section', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('.fields').slideUp().next('.add-section').slideUp()
    event.preventDefault()

  $('html.editions.edit form').submit (event) ->
    fields = $(this).find('.fields')
    fields.each (index) ->
      $(this).find('input[id$="position"]').attr('value', index + 1)

  $('html.editions.edit form').on 'click',  'a.section-up', (event) ->
    fields =  $(this).closest('.fields')
    buttons = fields.next('div.add-section')
    target = fields.prevAll('.fields').first()
    if target.size() > 0
      buttons.remove()
      fields.remove()
      target.before(fields).before(buttons)
    event.preventDefault()

  $('html.editions.edit form').on 'click',  'a.section-down', (event) ->
    fields =  $(this).closest('.fields')
    buttons = fields.next('div.add-section')
    target = fields.nextAll('.fields').first()
    if target.size() > 0
      buttons.remove()
      fields.remove()
      target.after(fields).after(buttons)
    event.preventDefault()
