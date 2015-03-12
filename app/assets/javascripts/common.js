$(function() {
	$(".nav.navbar-nav > li > a").hover(function(){	
		$(this).children().each(function() {
			if ($(this).hasClass("social-content")) {
				$(this).toggle(true);
			}
		})
	},function() {
		$(this).children().each(function() {
			if ($(this).hasClass("social-content")) {
				$(this).toggle(false);
			}
		})
	});
});