$ ->
  $('.expansible a.expander').click (e) ->
    e.preventDefault()
    $(this).parent('.expansible').children('.expansor').toggle()

$ ->
  $('a.jsify').click (e) ->
    e.preventDefault()
    url = $(this).attr('href') + '.js'
    $.getScript(url)


