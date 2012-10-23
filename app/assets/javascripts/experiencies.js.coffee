$ ->
  if $('.experiencies.index').length
    width = $('.experiencie').first().width()
    $('.quadricula .experiencie img').one('load', ->
      img = $(this).css('width', 'auto')

      if $(this).height() < $(this).width() or $(this).height() < width
        $(this).css('max-width', '30000px')
        ratio = $(this).width() / $(this).height()
        $(this).height(width)
        $(this).width(width * ratio)
    ).each ->
      $(this).load() if $(this).complete || $(this).height() < width
