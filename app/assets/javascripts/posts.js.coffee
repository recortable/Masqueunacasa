$ ->
  active = $("div.archive ul.months li.month:first-child").addClass("active")
  active.siblings("li").find("h4").append "<span> &raquo; </span>"
  $("div.archive ul.months li.month:not(.active)").css("cursor", "pointer").live("click", ->
    $(this).addClass("active").css("cursor", "default").find("ul").first().slideDown()
    $(this).find("h4 span").remove()
    active.removeClass("active").css("cursor", "pointer").find("ul").slideUp()
    active.find("h4").append "<span> &raquo; </span>"
    active = $(this)
  ).find("ul").css "display", "none"