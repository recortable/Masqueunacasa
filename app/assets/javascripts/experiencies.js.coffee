$.fn.extend
  expand_image: ->
    return this.each ->
      img = $(this).find('img')
      if img.height() < 270
        ratio = img.width() / img.height()
        img.height 270
        img.width ratio * 270
