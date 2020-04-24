// 
// 初始化页面(所有页面公用)
// @KOEN 2011-11-29
// 2012-7-4 yy运维用户中心
//弹窗初始化
$.sysop.popup.init();
//删除关闭文字
$(function(){$('.pop-cont dt a.close').html('');});
//提示
$.sysop.tipHover.init();

//Tree菜单（左侧）
function loadMenuTree(){
	$.getJSON('/user/listPrewApp.do',function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		var data  = [];
		var menus = json.object;
		var menuFilter = {};
		for(var j=0;j<menus.length;j++){//屏蔽权限管理子子菜单
				var menu = {};
				menu["name"]=menus[j].cn_name;
				menu["parentId"]=menus[j].app_group_id;
				menu["sequence"]=menus[j].sequence;
				menu["url"]=menus[j].url;
				menu["value"]=menus[j].app_id;
				menu["checked"]=false;
				menu["children"]=[];
				
				//如果还没有添加分组
				if(!menuFilter[menus[j].app_group_id]){
					var parentMenu = {};
					parentMenu["name"]=menus[j].group_name;
					parentMenu["parentId"]=0;
					parentMenu["sequence"]=menus[j].sequence;
					parentMenu["url"]="#";
					parentMenu["value"]=menus[j].app_group_id;
					parentMenu["checked"]=false;
					parentMenu["children"]=[];					
					menuFilter[parentMenu.value]=parentMenu;
					data.push(parentMenu);
				}
				
				var children = menuFilter[menus[j].app_group_id].children;
				children.push(menu);
			
		}
		initMenu(data);
		localStorage.frontMenuData=$.sysop.kit.obj2Str(data);
	})
}
//生成菜单函数
function initMenu(data){
	var menu=new menuTree();
	menu.bindData(data);
	menu.draw('#menuTree',{unfold:true,newWindow: true});
	//增加小圆点
	//$('#menuTree b').html('&middot;');
}
$(function(){
	  if(localStorage.frontMenuData != null){
		  var test = localStorage.frontMenuData;
		  var menus = eval('('+test+')'); 
		  initMenu(menus);
	  }else{
		  loadMenuTree();
	  }
	//点击隐藏/显示
	$('.left .toggle').toggle(function(){
		$(this).prev().hide();
		$('#sec-right').css({marginLeft:0});
		$(this).addClass('toggle-left');
		localStorage.treeMenu='hide';
	},function(){
		$(this).removeClass('toggle-left');
		var left=parseInt($(this).css('left'));
		$(this).prev().show();
		$('#sec-right').css({marginLeft:left+20});
		localStorage.treeMenu='show';
	});
	if(localStorage.treeMenu=='hide') $('.left .toggle').click();

});

//20120704
// 显示日历
var showCalendar = function($start,$end){
	for( var i = 0, len = arguments.length; i < len; i++){
		arguments[i].focus(function(){
			$(this).calendar();
		})
	}
}
// 删除行
var delRow = function($obj,uid){
	//callback del row
	var callback = function(){
		$obj.closest('tr').remove();
		$.sysop.popup.tip('提示','删除成功！');
	}
	$.sysop.popup.confirm('提示','确认删除？',{},callback);
}
$(function(){
	//调用树菜单
	//initMenu(userMenu,'menuTree_user');
	//initMenu(adminMenu,'menuTree');
	/* 全局js */
	// 滚动固定显示
	var $Win = $(window),
		oLeftSideMenu = $('#sec-left'),
		mainTitle = $('#mainTitle');
	var fixPannel = function($pannel,top){
		if( $Win.scrollTop() > 60){
			$pannel.addClass('pannelFixed');
		} else{
			$pannel.removeClass('pannelFixed');
		}
	}
	//关闭悬浮提示层
	var closeBugTips = function(){
             $('#J_bugLinkTips').fadeOut();
        }
        
	//回到顶部
	var goBackTop = function(){
		var top = 500;
		var appendDiv = function(){
			var oBackTop = $('<div class="backTop" id="J_backTop"><span>返回顶部</span></div>');
		 	$('body').append(oBackTop);
		 	var el = $('#J_backTop');
		 	var right = 5;
		 	el.css({'right':right}).click(function(){
				$('html,body').animate({'scrollTop':0},200);
			})
		}
		if( $Win.scrollTop() > top){
			if( !$('#J_backTop')[0]){
				appendDiv();
			}
			$('#J_backTop').fadeIn('slow');
		} else{
			if( $('#J_backTop')[0]){
				$('#J_backTop').fadeOut('slow');
			}
		}
	}
	$Win.scroll(function(){
		goBackTop();
		fixPannel(oLeftSideMenu);
		fixPannel(mainTitle);
	})
	var timer = setTimeout(closeBugTips,3000);
        $('.bug_link_tips .close').click(function(){
            closeBugTips();
            return false;
        })
});


function setFormatDate(time,dateType){ // time = 毫秒数,返回格式化后的日期;dateType = 'date' || 'minute' || '';
	if(time === NaN || time === null || time === ''){
		return '--';
	}
	var splitDate = function(v){
		return (v + '').length === 1 ? '0' + v : v;
	}
	var d = new Date(time), formatDate = '';
		year = d.getFullYear(), month = d.getMonth() + 1, date = d.getDate(),
		h = d.getHours(), m = d.getMinutes(), s = d.getSeconds();
	if(dateType === 'date'){ // 只显示日期 2012-12-12
		formatDate = year + '-' + splitDate(month) + '-' + splitDate(date); 
	} else if(dateType === 'minute'){ //显示到分钟 2012-12-12 18:30
		formatDate = year + '-' + splitDate(month) + '-' + splitDate(date) + ' ' + splitDate(h)  + ':' + splitDate(m); 
	} else{ //参数为空 显示全部 2012-12-12 18:30:12
		formatDate = year + '-' + splitDate(month) + '-' + splitDate(date) + ' ' + splitDate(h)  + ':' + splitDate(m) + ':' + splitDate(s); 
	}
	return formatDate;	
}