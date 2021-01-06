var loc = location.href;
var file = loc.substring(loc.lastIndexOf("/")+1,loc.length);
$('.header-link').children('a[href$="'+file+'"]').parent().addClass('active');