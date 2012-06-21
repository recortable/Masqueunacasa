$ ->
  $('.expansible a.expander').click (e) ->
    e.preventDefault()
    $(this).parent('.expansible').children('.expansor').toggle()

