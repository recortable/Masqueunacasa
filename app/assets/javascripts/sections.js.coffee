$(document).on "nested:fieldAdded", (event) ->
  event.field.parent('p').before(event.field)

init = ->
  $("fieldset").on "change", "input[type='file']", ->
    thumb_container = $(this).closest('div.control-group').siblings('.image-preview')
    img_tag = $("<img />")
    file = @files[0]
    reader = new FileReader()
    reader.onload = (event) ->
      img_tag.attr "src", event.target.result
      thumb_container.html img_tag

    reader.readAsDataURL file

$(document).ready(init)
$(window).bind('page:change', init)

