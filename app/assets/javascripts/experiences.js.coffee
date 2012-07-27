$.fn.extend
  center_image_v: ->
    return this.each ->
      img = $(this).find('img')
      if img.height() < 170
        ratio = img.width() / img.height()
        img.height 170
        img.width ratio * 170
