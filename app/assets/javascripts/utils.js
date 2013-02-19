if (typeof console == "undefined" || typeof console.log == "undefined") {
  console = {
    log : function() {
    }
  };
}

$.fn.extend({
  image_cache_src: function() {
    return this.each(function() {
      var self = $(this);
      if (self.attr('src').indexOf('uploads/tmp/')) {
        new_src = self.attr('src').replace(/http:\/\/.+\/uploads\/tmp\//, "/uploads/tmp/");
        self.attr('src', new_src);
      }
    });
  }
});

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

