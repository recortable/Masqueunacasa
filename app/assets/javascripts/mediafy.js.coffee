class Mediafy
  constructor: ->
    @renders = []

  addRender: (render) ->
    @renders.push render

  getMedia: (link) ->
    # console.log link
    if link?
      for render in @renders
        media = render.getMedia(link)
        if media
          # console.log media
          media.renderer = render
          media.type = render.name
          return media

# Create the Mediafy object
mediafy = new Mediafy

# Register renders
mediafy.addRender
  name: 'YouTube'
  getMedia: (link) ->
    if (link.match('(www.)?youtube|youtu\.be'))
      if (link.match('v='))
        { id: Util.getUrlVars(link)['v'] }
  embed: (media) ->
    "<iframe type='text/html' width='500' height='290'
    src='http://www.youtube.com/embed/#{media.id}'
    frameborder='0' />"

mediafy.addRender
  name: 'Image'
  getMedia: (link) ->
    if (link.match(/jpg|jpeg|png|gif/i) || link.match("staticmap") || link.match("yfrog.com") || link.match("twitpic.com"))
      { id: link }
  embed: (media) ->
    "<img src='#{media.id}' />"

mediafy.addRender
  name: 'Vimeo'
  getMedia: (link) ->
    if (link.match('(player.)?vimeo\.com'))
      { id: link.split(/video\/|\/\/vimeo\.com\//)[1].split(/[?&]/)[0] }
  embed: (media) ->
    "<iframe src='http://player.vimeo.com/video/#{media.id}' width='500' height='290' frameborder='0' 
    webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>"


$.fn.extend
  mediafy: ->
    return this.each ->
      link = $(this).attr('href')
      media = mediafy.getMedia(link)
      if media
        rendered = media.renderer.embed(media)
        embed = "<div class='embed-container'>#{rendered}</div>"
        if this.parentNode.firstChild == this
          $(this).html(embed)
        else
          element = null
          $(this).click (e) ->
            e.preventDefault()
            if element 
              $(element).toggle()
            else
              element = $(embed).appendTo($(this))

