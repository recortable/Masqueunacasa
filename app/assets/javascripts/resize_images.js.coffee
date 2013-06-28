initResizeImages = ->
  $('.lista-visor.experiencies').imagesLoaded().
    progress (instance, image) ->
      img = $(image.img)
      visorElement = img.closest('.visor-elem')

      if img.width() < visorElement.width() / 2
        img.width( visorElement.width() / 2 )

      if img.height() < visorElement.height()
        aspect_ratio = img.width() / img.height()
        img.height(visorElement.height())
        img.width(visorElement.height() * aspect_ratio)

$(document).ready(initResizeImages)
$(window).bind('page:change', initResizeImages)

