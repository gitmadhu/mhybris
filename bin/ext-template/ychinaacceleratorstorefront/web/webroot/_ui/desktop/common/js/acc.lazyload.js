/* CHINAACC:NEWFILE */

$(function(){
	var lazyLoadConfig = $(".lazyLoadConfig").data("lazyLoadConfig");
	var timeout = $(".lazyLoadConfig").data("timeout");

	$("img.lazy").lazyload(lazyLoadConfig);
	
	if(timeout){
		setTimeout(function() {$("img.lazy").lazyload(lazyLoadConfig)}, timeout);
	}
});