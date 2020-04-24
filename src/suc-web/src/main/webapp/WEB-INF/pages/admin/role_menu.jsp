<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>菜单管理</span></h2>
			<div class="mainContent" >
				<!-- 编辑编辑权限树 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>角色(<span class="role_info"></span>)菜单资源分配</h4>
					</div>
					<!-- <div class="top">
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
				      	<div class="field">
				      		<input type="button" onclick="history.back()" value="« 返回" />
				      	</div>
				      </form>
				    </div> -->
				<div class="cont-border" >
					<form id="f_1">
	                <table id="f_tb" class="form mt0">
	                	<tbody>
	                        <tr>
	                        	<td>
	                            	<div id="menuTreeOS" class="menuTreeOs">treeMenu</div>
	                            	<br>
	                            	<div class="nav">
	               						<input type="button" onclick="history.back()" value="« 返回" /> |
	               						<input type="button" id="saveTree" value="保存" /> 
	           						 </div>
	                            </td>
	                        </tr>
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
var name=$.sysop.kit.getUrlValue('name');
$('.tit').find('.role_info').html(name);

//过滤数组
function filterTreeData(listData){
	var treeData = [];
	var isNeed = function(menu,parent_id){
		if( menu.parent_id == parent_id){
			return true;
		}
		return false;
	};
	$.each( listData,function(){
		console.debug(this);
		if( this.parent_id == 0 && this.hide==0){
			this.checked = false;
			var currParentId = this.menu_id || this.resources_id;
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
	function reloadTree(){
		var app_id = $('#J_sysName').val();
		loadTreeMenuGroup(app_id,{unfold:true,checkbox:false,editable:true,link:false,fn_addItem:callback_addItem,fn_delItem:callback_delItem,fn_editItem:callback_saveTree});
	}
	//编辑树 保存功能
	function callback_saveTree(app_id){
		var json = menuOS.parseItem();
		var jsonStr = filter(json);
		var jsonStr2 = $.sysop.kit.obj2Str(jsonStr);
		
		var param = {};
		param["data"]=jsonStr2;
		$.post('/admin/menu/modifyMenu.do',param,function(data){
			if( data.success){ 
				$.sysop.popup.autoTip('操作成功！');
				reloadTree();
			} else {
				alert(data.message);
			}
		});
	}
	
	//渲染树
	function loadTreeMenuGroup(app_id,setting){ //setting : {unfold:true,checkbox:false,editable:true,link:false}
		$.getJSON('/admin/appResource.do?app_id='+app_id,function(data){
			if( data.success){
				var list = filterTreeData(data.object);
				menuOS = new menuTree();
				menuOS.bindData(list);
				menuOS.draw('#menuTreeOS',setting);
			} else {
				alert(data.message);
			}
		});
	}
	//渲染 子树
	function loadChildTree(menu_id,setting){ //setting : {unfold:true,checkbox:false,editable:true,link:false}
		$.getJSON('/admin/getRoleMenu.do?role_id='+menu_id,function(data){
			if( data.success){
				var list = filterTreeData(data.object);
				//var jsonStr3 = $.sysop.kit.obj2Str(list);
				menuOS2 = new menuTree();
				menuOS2.bindData(list);
				menuOS2.draw('#menuTreeOS',setting);
			} else {
				alert(data.message);
			}
		});
	}
	//从树节点加载树
	var showTree = function(menu_id,flag){
		loadChildTree(menu_id,{unfold:true,checkbox:true,editable:false,link:false});
	};
	var role_id = $.sysop.kit.getUrlValue('id');
	showTree(role_id);
	//过滤 check 复选框
	var checkFilter = function(arr){
		var newarr = $.grep(arr,function(item){
			return item.checked == true;
		});
		return newarr;
	};
	//保存子树
	var saveTree = function(menu_id){
		var json = menuOS2.parseItem();
		var jsonStr = filter(json);
		var cf = checkFilter(jsonStr);
		var jsonStr2 = $.sysop.kit.obj2Str(cf);
		var param = {};
		param["role_id"]=role_id;
		param["data"]=jsonStr2;
		
		console.log(jsonStr2);
		
		$.post('/admin/updateRoleMenu.do',param,function(data){
			if( data.success){
				$.sysop.popup.autoTip('操作成功！');
			} else {
				alert(data.message);
			}
		});
		//showTree(role_id);
	};
	
	$('#saveTree').click(saveTree);
});
</script>
</body>
</html>
