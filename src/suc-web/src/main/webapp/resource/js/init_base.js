// 
// 初始化页面(所有页面公用)
// @KOEN 2011-11-29
// 2012-7-4 yy运维用户中心
//全局异常统一提示
$.ajaxSetup({
	   error:function(err){
			alert(err.response);
	   }
});
//弹窗初始化
$.sysop.popup.init();
//删除关闭文字
$(function(){$('.pop-cont dt a.close').html('');});
//提示
$.sysop.tipHover.init();


//Tree菜单（左侧）

$(function(){
		
	
	  if(localStorage.getItem("menuData") != null){
		  var test = localStorage.getItem("menuData");
		  var menus = eval('('+test+')'); 
		  initMenu(menus);
	  }else{
		$.getJSON('/admin/menu.do',function(json){//初始化侧栏菜单
			if(!json.success) {
				alert(json.message);
				return;
			}
			var data  = [];
			var menus = json.object;
			var menuFilter = {};
			
			//先加载第一级菜单
			for(var j=0;j<menus.length;j++){
				if(menus[j].parent_id==0){
					var menu = {};
					menu["name"]=menus[j].name;
					menu["parentId"]=menus[j].parent_id;
					menu["sequence"]=menus[j].sequence;
					menu["url"]=menus[j].url;
					menu["value"]=menus[j].menu_id;
					menu["checked"]=false;
					menu["children"]=[];
					
					menuFilter[menus[j].menu_id]=menu;
					data.push(menu);				
				}
			}
			//加载第二级菜单
			for(var j=0;j<menus.length;j++){//屏蔽权限管理子子菜单
				if(menus[j].parent_id!=0){		
					var menu = {};
					menu["name"]=menus[j].name;
					menu["parentId"]=menus[j].parent_id;
					menu["sequence"]=menus[j].sequence;
					menu["url"]=menus[j].url;
					menu["value"]=menus[j].menu_id;
					menu["checked"]=false;
					menu["children"]=null;
					var children = menuFilter[menus[j].parent_id].children;
					children.push(menu);
				}
			}
			initMenu(data);
			console.debug(data);
			localStorage.setItem("menuData",$.sysop.kit.obj2Str(data));
		});
	
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
	//生成菜单函数
	function initMenu(data){
		var menu=new menuTree();
		menu.bindData(data);
		menu.draw('#menuTree',{unfold:true});
	}
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
		//fixPannel(oLeftSideMenu);
		//fixPannel(mainTitle);
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

$.sysop.select={
	initSelect:function(select,data){
		var html='<option value="">请选择</option>';
		$.each(data,function(i,value){
			html+='<option value='+value+'>'+value+'</option>';
		});
		select.html(html);
	},
	initProvinceCity:function(province,city,val1,val2){
		$.getJSON('/GIPrpvinceCityInfo/listAllProvince.do',function(json){
			$.sysop.select.initSelect(province,json.object);
		});
		province.change(function(){
			var req='province='+province.val();
			$.getJSON('/GIPrpvinceCityInfo/listCity.do',req,function(json){
				$.sysop.select.initSelect(city,json.object);
			});
		});
	},
	bindVal:function(province,city,val1,val2){
		province.val(val1);
		province.change();
		city.val(val2);
	}
};

window.alert = function showDialog(msg,callback){
	var dialog = jDialog.alert(msg,{},{
		showShadow: false,// 不显示对话框阴影
		buttonAlign : 'center',
		events : {
			show : function(evt){
				var dlg = evt.data.dialog;
			},
			close : function(evt){
				var dlg = evt.data.dialog;
				callback && callback();
			},
			enterKey : function(evt){
				alert('enter key pressed!');
			},
			escKey : function(evt){
				alert('esc key pressed!');
				evt.data.dialog.close();
			}
		}
	  });
}
