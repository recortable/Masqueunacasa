init = ->
  categories = $('body.phases.index .category')

  categories.each ->
    self = $(this)
    ul = self.find('.category-proposals ul')

    self.find('.toggle-proposals-list').css('cursor', 'pointer').on 'click', ->
      $(this).next('ul').slideToggle().end().
        find('i').toggleClass('icon-expand icon-collapse')
    .append(" <i class='icon-expand'></i>")

    self.find('.category-proposals ul').hide()

$(document).ready(init)
$(window).bind('page:load', init)
