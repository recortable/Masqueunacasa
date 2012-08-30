$.fn.extend
  expand_image: ->
    return this.each ->
      cont = $(this)
      img = cont.find('img')
      # console.log(img.height())
      if img.height() == 0
        #console.log("1")
        img.bind 'load', ->
          ratio = img.width() / img.height()
          img.height 150
          img.width ratio * 150
      else if img.height() < 150
        ratio = img.width() / img.height()
        img.height 150
        img.width ratio * 150
