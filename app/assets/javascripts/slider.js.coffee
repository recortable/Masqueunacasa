$.fn.extend
  applySlider: ->
    return this.each ->
      # Copiamos los textos y los añadimos con visibility hidden
      # para que el slider pille la altura adecuada
      text_boxes = $(this).find('.slide-text').clone().addClass('clone')
      $(this).orbit({
        fluid: true,
        advanceSpeed: 10000,
        pauseOnHover: true,
        timer: true,
        startClockOnMouseOut: true
      });
      $(this).prepend(text_boxes)
