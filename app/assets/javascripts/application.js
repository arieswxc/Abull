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
//= require ckeditor/init
//= require_tree .
//= require jquery_nested_form
//= require 'china_city/jquery.china_city'


function check_length(em){
  em.each(function(){
    var _self = this;
    var tmpval = $(_self).val().length;
    var validate = true;
    if ($(_self).attr("maxlength")) {
      var  maxl = parseInt($(_self).attr("maxlength"));
      if (tmpval > maxl) {
        zzToolTip(_self);
        validate = false;
        // _self.setCustomValidity($(_self).attr('tooltip')+"，当前字数"+tmpval);
      }
    }
    if ($(_self).attr("minlength")) {
      var minl = parseInt($(_self).attr("minlength"));
      if (tmpval < minl) {
        zzToolTip(_self);
        validate = false;
      }
    }
    if (validate == true){
      zzToolTip(_self,"false");
    }
    // _self.setCustomValidity("");
  });
}
function check_val(em){
  em.each(function(){
    var _self = this;
    var tmpval = parseInt($(_self).val()) || 0;
    if (tmpval > 0) {
      zzToolTip(_self,"false");
    } else {
      zzToolTip(_self);
    }
  });
}
function scrollToErr() {
  if ($(".state-error").length > 0) {
    var scroll_offset = $(".state-error").offset(); //得到pos这个div层的offset，包含两个值，top和left
    $("body,html").animate({
      scrollTop:scroll_offset.top //让body的scrollTop等于pos的top，就实现了滚动
    },300);
    return false;
  }
  return true;
}

function zzToolTip(elem){
  var _self = elem;
  if (arguments[1] && arguments[1] == "false"){
    $(_self.parentNode).find('.zztooltip').stop(true,true);
    $(_self.parentNode).removeClass("state-error");
    $(_self.parentNode).find('.zztooltip').css({opacity:0});
    $(_self.parentNode).find('.zztooltip').hide();
  }else{
    $(_self.parentNode).addClass("state-error");
    if (!$(_self).attr('tooltip')){
      $(_self).attr('tooltip','请填写该字段');
    }
    if ($(_self.parentNode).find('.zztooltip').length > 0){
      $(_self.parentNode).find('.zztooltip').html("<i class='fa fa-exclamation-triangle'></i>  "+$(_self).attr('tooltip'));
      $(_self.parentNode).find('.zztooltip').stop(true,true);
      $(_self.parentNode).find('.zztooltip').css({'opacity':1,'display':'block'});
      $(_self.parentNode).find('.zztooltip').animate({'opacity':0},3000);
      setTimeout(function(){
        $(_self.parentNode).find('.zztooltip').hide();
      },3000);
    }else {
      $(_self.parentNode).append("<div class='zztooltip'><i class='fa fa-exclamation-triangle'></i>  "+$(_self).attr('tooltip'));
      $(_self.parentNode).find('.zztooltip').css({'opacity':1,'display':'block'});
      var ptop = $(_self.parentNode).height() + 1;
      $(_self.parentNode).find('.zztooltip').css({'top': ptop + 'px'});
      $(_self.parentNode).find('.zztooltip').animate({'opacity':0},3000);
      setTimeout(function(){
        $(_self.parentNode).find('.zztooltip').hide();
      },3000);
    }
  }
  _self.setCustomValidity("");
}

$.v = function(){
  if (arguments[1]){
    return $("#" + arguments[0]).val(arguments[1]);
  }else {
    return $("#" + arguments[0]).val();
  }

};

$(function(){
  $("body").bind("click",function(){
    if ($('.zztooltip').css('display') === 'block'){
      $('.zztooltip').animate({'opacity':0},3000);
    }
  });
});
