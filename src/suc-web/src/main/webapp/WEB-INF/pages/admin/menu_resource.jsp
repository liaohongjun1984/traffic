<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>菜单资源设置</span></h2>
			<div class="mainContent" >
				<!-- 编辑编辑权限树 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>菜单资源分配</h4>
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
	                <table id="f_tb" class="form mt0" style="margin-top: 0;">
	                	<tbody>
	                        <tr>
	                        	<td width="30%">
	                            	<div style="width: 95%;" id="menuTreeOS" class="menuTreeOs">treeMenu</div>
	                            </td>
	                            <td width="70%">
	                            	<div style="width: 95%;" id="menuTreeOS2" class="menuTreeOs">treeMenu</div>
	                            </td>
	                        </tr>
	                        <tr>
	                        	<td></td>
	                        	<td>
	                        		<div class="nav">
                   						<input type="button" onclick="history.back()" value="« 返回" /> |
                   						<input type="button" class="saveTree" id="add_save" value="保存" />
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
	
	//渲染树
	function loadTreeMenuGroup(app_id,setting){ //setting : {unfold:true,checkbox:false,editable:true,link:false}
		$.getJSON('/admin/menu/listByAppId.do?app_id='+app_id,function(data){
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
		$.getJSON('/admin/menu/getMenuResource.do?menu_id='+menu_id,function(data){
			if( data.success){
				var list = filterTreeData(data.object);
				var jsonStr3 = $.sysop.kit.obj2Str(list);
				menuOS2 = new menuTree();
				menuOS2.bindData(list);
				menuOS2.draw('#menuTreeOS2',setting);
			} else {
				alert(data.message);
			}
		});
	}
	//分组
	var loadGroupList = function(){
		$.getJSON('/admin/appGroupList.do',function(data){
			if( data.success){
				var list = data.object;
				$.each(list,function(n,item){
					$('#J_sysGroup').append('<option value="'+item.app_group_id+'">'+item.name+'</option>');
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
		$.getJSON('/admin/getAppList.do?app_group_id='+id+'&status=1',function(data){
			if( data.success){
				var list = data.object;
				$('#J_sysName').html('<option value="">请选择</option>');
				$.each(list,function(n,item){
					$('#J_sysName').append('<option value="'+item.app_id+'">'+item.cn_name+'</option>');
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
	
	//从树节点加载树
	var showTree = function(menu_id,flag){
		loadChildTree(menu_id,{unfold:true,checkbox:true,editable:false,link:false,chlidTree:true});
	};
	//加载树形菜单
	$('#J_sysName').change(function(){
		var app_id = $(this).val();
		loadTreeMenuGroup(app_id,{unfold:true,checkbox:false,editable:false,showChildTree:true,link:false,fn_showTree:showTree});
	});
	//过滤 check 复选框
	var checkFilter = function(arr){
		var newarr = $.grep(arr,function(item){
			return item.checked == true;
		});
		return newarr;
	};
	//保存子树
	var saveTree = function(menu_id){
		var mid = $('#menuTreeOS').attr('menu_id');
		var json = menuOS2.parseItem();
		var jsonStr = filter(json);
		var cf = checkFilter(jsonStr);
		var jsonStr2 = $.sysop.kit.obj2Str(cf);
		var param = {};
		param["data"]=jsonStr2;
		
		console.log(jsonStr2);
		param["menu_id"]=mid;
		$.post('/admin/menu/modifyMenuResource.do',param,function(data){
			if( data.success){
				$.sysop.popup.autoTip('操作成功！');
			} else {
				alert(data.message);
			}
		});
	};
	var saveTree2 = function(){
		var json = menuOS2.parseItem();
		var jsonStr2 = filter(json);
		var jsonStr3 = $.sysop.kit.obj2Str(jsonStr2);
		console.log(json);
		//console.log(jsonStr);
		console.log(jsonStr2);
		console.log(jsonStr3);
		return false;
	};
	$('.saveTree').click(saveTree);
});
</script>
</body>
</html>
