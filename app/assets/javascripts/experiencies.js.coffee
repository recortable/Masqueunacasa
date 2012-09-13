$.fn.extend
  expand_image: ->
    return this.each ->
      cont = $(this)
      img = cont.find('img')
      wth = cont.width()
      # console.log(img.height())
      if img.height() == 0
        #console.log("1")
        img.bind 'load', ->
          ratio = img.width() / img.height()
          img.height wth
          img.width ratio * wth
      else if img.height() < wth
        ratio = img.width() / img.height()
        img.height wth
        img.width ratio * wth
