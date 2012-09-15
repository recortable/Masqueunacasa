$(function(){
  var link = $('.add_nested_fields').first()

  $('fieldset.sections-fields .fields').each(function() {
    $(this).before(link.clone())
  });

  window.nestedFormEvents.insertFields = function(content, assoc, link) {
    return $(link).after($(link).clone()).after($(content));
  }
});
