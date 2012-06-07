$ ->
  archive()
  post_options()

archive = ->
  active = $("div.archive ul.months li.month:first-child").addClass("active")
  active.siblings("li").find("h4").append "<span> &raquo; </span>"
  $("div.archive ul.months li.month:not(.active)").css("cursor", "pointer").live("click", ->
    $(this).addClass("active").css("cursor", "default").find("ul").first().slideDown()
    $(this).find("h4 span").remove()
    active.removeClass("active").css("cursor", "pointer").find("ul").slideUp()
    active.find("h4").append "<span> &raquo; </span>"
    active = $(this)
  ).find("ul").css "display", "none"

post_options = ->
  hide_unchecked(null)
  $("input[name=\"post-options\"]").change ->
    hide_unchecked('slow')

hide_unchecked = (speed)-> 
  input_img = $(".img-input").first().html()
  switch $("input:radio[name=\"post-options\"]:checked").val()
    when "simple"
      $(".img-input, .embed-input").hide speed, ->
        clear_img(input_img)
        clear_video()
    when "with-img"
      $(".img-input").show speed
      $(".embed-input").hide speed,  ->
        clear_video()
    when "with-video"
      $(".embed-input").show speed
      $(".img-input").hide speed, ->
        clear_img(input_img)
            

clear_video = ->
  $(".embed-input textarea").val("")

clear_img = (content) ->
  $(".img-input").html(content)