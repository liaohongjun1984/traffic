function loadUserInfo(){
	if(localStorage.getItem("userNickName") != null){
		$("#userInfo").html(localStorage.getItem("userNickName"));
		$("#userInfo").attr("href","/user/user_view.jspx?user_name="+localStorage.getItem("userName"));
	}else{
	$.getJSON("/common/loadUserInfo.do",function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		var user = json.object;
		if(user.admin==1){
			$("#haveAdmin").show();
		}
		$("#userInfo").html(user.nick_name);
		$("#username").text(user.user_name);
		localStorage.setItem("userNickName",user.nick_name);
		localStorage.setItem("userName",user.user_name);
		$("#userInfo").attr("href","/user/user_view.jspx?user_name="+user.user_name);
	
	});	
	}
}
function loadServerIp(){
	if(localStorage.getItem("ips") != null){
		$("#serverIps").html("当前服务器IP:"+localStorage.ips);
		console.debug(localStorage.getItem("ips"));
		localStorage.removeItem("ips");
	}else{
	$.getJSON("/common/loadServerIp.do",function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}	
		var ips = json.object;
		$("#serverIps").html("当前服务器IP:"+ips.join(","));
		localStorage.setItem("ips",$.sysop.kit.obj2Str(ips.join(",")));
	});			
	}
}
var showLinksList = function(e){
	$('.btn-mini').bind('click',function(e){
		$('.dropdown-menu').show();
		e.stopPropagation();
	})
	$('body').click(function(){
		$('.dropdown-menu').hide();
	})
}

/**
 * 加载应用列表
 */
function loadAppList(){
	var url = '/user/listPrewApp.do',
		liTemp = '<li><a href="<%= url %>" target="_blank"><%= cn_name %></a></li>',
		$root = $('#top_app_list').empty();
	$.ajax({
		url : url,
		success : function(obj){
			if(obj.success){
				var list = obj.object;
				_.each(list, function(appInfo){
					var $li = $(_.template(liTemp, appInfo));
					$root.append($li);
				});
			}
		}
	});
};

$(document).ready(function (){
	loadUserInfo();
	loadServerIp();
	showLinksList();
	loadAppList();
});