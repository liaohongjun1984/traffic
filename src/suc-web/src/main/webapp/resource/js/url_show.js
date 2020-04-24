//图片弹窗
function url_show(url){
	var img = new Image();
	
	img.onload = img.onerror = function(){
	
		img.onload = img.onerror = null;
		
		$("body").append('<div class="popup_tp"><img src='+url+' alt="" style="display:inline-block;" ></div>');
		$("body").append('<div class="beijing"></div>');
		$(".beijing").height($(document).height());
		$(".beijing").show();
		$(".popup_tp").width($(".popup_tp>img").width());
		$(".popup_tp").height($(".popup_tp>img").height());
		$(".popup_tp").css({"margin-left":-$(".popup_tp").width()/2,"margin-top":-$(".popup_tp").height()/2});
		$(".beijing").click(function(){
			$(".beijing").remove();
			$(".popup_tp").remove();
		});
	};
	img.src=url;
};