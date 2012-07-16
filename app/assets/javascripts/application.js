//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require ckeditor/init
//= require shared
//= require posts
//= require_self
//= require maps
//= require mediafy

$(function() {
  $('div.locations').showMap();
  $('form.new_location').mapForForm();
  $('form.edit_location').mapForForm();
});

$(function() {
  $('.complete_task').click(function() {
    var box = $(this);
    $.ajax({
      url: $(this).data('url'),
      type: 'PUT',
      dataType: 'html',
      success: function(data) {
        box.siblings('span').toggleClass('finished');
        console.log(data);
      }
    });
  });
});

CKEDITOR.replaceClass = 'rte';

if (typeof console == "undefined" || typeof console.log == "undefined") {
  console = {
    log : function() {
    }
  };
}

window.Util = {
  /* Get URL Variables
     ================================================== */
  // var somestring = Util.getUrlVars(str_url)["varname"];
  getUrlVars: function(string) {

    var str = string.toString();

    if (str.match('&#038;')) {
      str = str.replace("&#038;", "&");
    } else if (str.match('&#38;')) {
      str = str.replace("&#38;", "&");
    } else if (str.match('&amp;')) {
      str = str.replace("&amp;", "&");
    }

    var vars = [], hash;
    var hashes = str.slice(str.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++) {
      hash = hashes[i].split('=');
      vars.push(hash[0]);
      vars[hash[0]] = hash[1];
    }

    return vars;
  }
}
