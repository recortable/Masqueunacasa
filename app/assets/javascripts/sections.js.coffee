jQuery ->
  $('form fieldset.sections-fields').on 'click', 'a.add-section', (event) ->
    $(this).css('display', 'none').siblings('.add_fields').css('display', 'inline-block')
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    $(this).css('display', 'none').siblings('.add_fields').css('display', 'none').first()
    $(this).siblings('a.add-section').css('display', 'inline-block')
    links = $(this).closest('div.add-section').clone()
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    content = $($(this).data('fields').replace(regexp, time)).css('display', 'none')
    $(this).closest('div.add-section').after(links).after(content)
    content.slideDown(500)
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
