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
  $(".img-input, .embed-input").css "display", "none"
  $("input[name=\"post-options\"]").change ->
    switch $("input:radio[name=\"post-options\"]:checked").val()
      when "simple"
        $(".img-input, .embed-input").hide "slow"
      when "with-img"
        $(".img-input").show "slow"
        $(".embed-input").hide "slow"
      when "with-video"
        $(".embed-input").show "slow"
        $(".img-input").hide "slow"