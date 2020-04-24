<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>系统字典管理</span></h2>
			<div class="mainContent" >
				<!-- 编辑编辑权限树 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>编辑字典树</h4>
					</div>
					<div class="top">
				      <form id="search_form" name="search_form">
				      	<div class="field">
				      		<label for="J_sysGroup">系统分组：</label>
				      		<select id="J_sysGroup" name="">
				      			<option value="0">请选择</option>
				      		</select>
				      		<label for="J_sysName">系统名称：</label>
				      		<select id="J_sysName" name="">
				      			<option value="0">请选择</option>
				      		</select>
				      	</div>
				      </form>
				    </div>
				<div class="cont-border" >
					<form id="f_1">
	               <table class="cyan tb-actorList">
							<thead>
								<tr>
									<td>系统ID</td>
									<td>系统分组</td>    
									<td>系统中文名称</td>     
									<td>系统英文名称</td>            
									<td>系统描述</td>
									<td>操作项</td>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
                </form>

				<!-- 编辑编辑权限树 end -->
			</div>
		</div>
		<!-- right end -->
	</div>
	<!-- mani end -->
	<div class="footer clearfix"></div>
</div>
<script>
//过滤数组
function filterTreeData(listData){
	var treeData = [];
	var isNeed = function( menu,parent_id){
		if( menu.parent_id == parent_id){
			return true;
		}
		return false;
	};
	$.each( listData,function(){
		if( this.parent_id == 0){
			this.checked = false;
			var currParentId = this.menu_id;
			var children = $.grep(listData,function(menu){
				return isNeed(menu,currParentId);
			}); 
			this.children = children;
			treeData.push(this);
		}
	});
	return treeData;
}
//反向
var filter = function(arr){
	var newarr = [];
	$.each(arr,function(i,n){
		if( n.children){
			newarr = newarr.concat(n.children);
			delete n.children;
		}
	});
	if( newarr.length !== 0){
		$.each(newarr,function(i,n){
			arr.push(n);
		});
	}
	return arr;
};
$(function(){
	$.ajaxSetup({
		cache:false
	})
	function reloadTree(){
		var app_id = $('#J_sysName').val();
		loadTreeMenuGroup(app_id,{unfold:true,checkbox:false,editable:true,link:false,fn_addItem:callback_addItem,fn_delItem:callback_delItem,fn_editItem:callback_saveTree,fn_reloadTree:reloadTree});
	}
	//编辑树 保存功能
	function callback_saveTree(app_id,flag){
		var json = menuOS.parseItem();
		var jsonStr = filter(json);
		var jsonStr2 = $.sysop.kit.obj2Str(jsonStr);
		
		var param = {};
		param["data"]=jsonStr2;
		$.post('/admin/menu/modifyMenu.do',param,function(data){
			if( data.success){ 
				if( !flag){
					$.sysop.popup.autoTip('操作成功！');
					reloadTree();
				}
			} else {
				alert(data.message);
			}
		});
	}
	//新增节点
	function callback_addItem(param){
		$.post('/admin/menu/addMenu.do?',param,function(data){
			if( data.success){ 
				$.sysop.popup.autoTip('操作成功！');
				reloadTree();
			} else {
				alert(data.message);
			}
		});
	}
	//删除节点
	function callback_delItem(menu_id){
		$.getJSON('/admin/menu/removeMenu.do?menu_id='+menu_id,function(data){
			if( data.success){ 
				$.sysop.popup.autoTip('操作成功！');
				reloadTree();
			} else {
				alert(data.message);
			}
		});
	}
	//loadTreeMenuGroup(1,{unfold:true,checkbox:false,editable:true,link:false,fn_addItem:callback_addItem,fn_delItem:callback_delItem,fn_editItem:callback_saveTree});
	//渲染树
	function loadTreeMenuGroup(app_id,setting){ //setting : {unfold:true,checkbox:false,editable:true,link:false}
		$.getJSON('/admin/menu/listByAppId.do?app_id='+app_id,function(data){
			if( data.success){
				var list = filterTreeData(data.object);
				console.log($.sysop.kit.obj2Str(list));
				if( list == ''){
					var arr = [{"app_id":app_id,"menu_id":'0',"parent_id":0,"name":"新增菜单","url":"#"}];
					var param = 'menu_id=0&parent_id=0&app_id='+app_id+'&name=新增菜单&url=#';
					menuOS = new menuTree();
					menuOS.bindData(arr);
					menuOS.draw('#menuTreeOS',setting);
					callback_addItem(param);
					return;
				}
				menuOS = new menuTree();
				menuOS.bindData(list);
				menuOS.draw('#menuTreeOS',setting);
			} else {
				alert(data.message);
			}
		});
	}
	//分组
	var loadGroupList = function(){
		$.getJSON('/admin/appList.do',function(data){
			if( data.success){
				var list = data.object;
				$.each(list,function(n,item){
					$('#J_sysGroup').append('<option value="'+item.app_id+'">'+item.cn_name+'</option>');
				});
			} else {
				alert(data.message);
			}
		});
	};
	//选择系统
	var loadAppList = function(id){
		if(id == 0 || id == '') {
			$('#J_sysName').html('<option value="0">请选择</option>');
			return;
		}
		$.getJSON('/admin/getMenuList.do?app_id='+id,function(data){
			if( data.success){
				var list = data.object;
				$('#J_sysName').html('<option value="">请选择</option>');
				$.each(list,function(n,item){
					$('#J_sysName').append('<option value="'+item.menu_id+'">'+item.name+'</option>');
				});
			} else {
				alert(data.message);
			}
		});
	};
	//加载分组
	loadGroupList();
	//加载系统列表
	$('#J_sysGroup').change(function(){
		loadAppList($(this).val());
	});
	//加载树形菜单
	$('#J_sysName').change(function(){
		var app_id = $(this).val();
		if( app_id == ''){
			alert('请选择');
			return;
		}
		loadTreeMenuGroup(app_id,{unfold:true,checkbox:false,editable:true,link:false,fn_addItem:callback_addItem,fn_delItem:callback_delItem,fn_editItem:callback_saveTree,fn_reloadTree:reloadTree});
	});
	
	var saveTree = function(){
		var json = menuOS.parseItem();
		//var jsonStr = $.sysop.kit.obj2Str(json);
		var jsonStr2 = filter(json);
		var jsonStr3 = $.sysop.kit.obj2Str(jsonStr2);
		console.log(json);
		//console.log(jsonStr);
		console.log(jsonStr2);
		console.log(jsonStr3);
		return false;
	};
	//$('#add_save').click(saveTree);
	//loadTreeMenuGroup(1,{unfold:true,checkbox:false,editable:true,link:false,fn_addItem:callback_addItem,fn_delItem:callback_delItem,fn_editItem:callback_saveTree});

});
</script>
</body>
</html>
