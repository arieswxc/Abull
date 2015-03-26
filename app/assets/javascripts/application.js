// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require jquery_nested_form
//= require 'china_city/jquery.china_city'


function check_length(em){
  em.each(function(){
    var _self = this;
    var tmpval = $(_self).val().length,
     maxl = parseInt($(_self).attr("maxlength")),
     minl = parseInt($(_self).attr("minlength"));
    if (tmpval > maxl || tmpval < minl ) {
      $(_self.parentNode).addClass("state-error");
    } else {
      $(_self.parentNode).removeClass("state-error");
    }
  });
}
function check_val(em){
  em.each(function(){
    var _self = this;
    var tmpval = parseInt($(_self).val()) || 0;
    if (tmpval > 0) {
      $(_self.parentNode).removeClass("state-error");
    } else {
      $(_self.parentNode).addClass("state-error");
    }
  });
}
function scrollToErr() {
  if ($(".state-error").length > 0) {
    var scroll_offset = $(".state-error").offset(); //得到pos这个div层的offset，包含两个值，top和left
    $("body,html").animate({
      scrollTop:scroll_offset.top //让body的scrollTop等于pos的top，就实现了滚动
    },300);
    return true;
  }
  return false;
}
