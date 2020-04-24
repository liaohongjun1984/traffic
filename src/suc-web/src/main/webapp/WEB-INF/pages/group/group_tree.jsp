<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>业务组织结构</span></h2>
			<div class="mainContent" >
				<!-- 编辑编辑权限树 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>组织结构查看</h4>
					</div>
					<div class="top">
				      <form id="search_form" name="search_form">
				      	<div id="J_selectZone" class="field none">
				      		<label for="J_sysName">浏览组织机构:</label>
				      		<select id="J_sysGroup" name="">
				      			<option value="">请选择</option>
				      		</select>
				      	</div>
				      </form>
				    </div>
				<div class="cont-border">
					<form id="f_1">
	                <table id="f_tb" class="form mt0" style="margin-top: 0;">
	                	<tbody>
	                        <tr>
	                        	<td width="40%">
	                            	<div style="width:95%;" id="menuTreeOS" class="menuTreeOs">treeMenu</div>
	                            </td>
	                            <td width="60%" class="checkGroupMember">
	                            	<div class="box-item">
	                            		<div class="tit"> <span class="arr"></span>
											<h4 id="J_tit">组员列表</h4>
											<button disabled="false" id="J_searchMember" class="button fr btn_small">添加</button>
										</div>
										<div class="top">
											<span class="role_tips"><i></i><label for="">管理员</label></span>
										</div>
	                            		<table class="cyan" id="tb_groupMember">
	                            			<thead>
	                            				<tr>
	                            					<td>账号</td>
	                            					<td>姓名</td>
	                            					<td>邮箱</td>
	                            					<td>操作</td>
	                            				</tr>
	                            			</thead>
	                            			<tbody>
	                            				<tr>
	                            					<td style="padding:20px 0; text-align: center; color: #f60" colspan="4">暂无数据</td>
	                            				</tr>
	                            			</tbody>
	                            		</table>
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
<div id="popup_member" class="modal">
	<div class="modal-header">
		<button class="btn_close cancel" type="button">×</button>
		<h3>添加组员</h3>
	</div>
	<div class="modal-body">
		<div class="searchMember">
			<label for="J_key">搜索：</label>
			<input type="text" placeholder="输入用户名查找，支持模糊搜索" name="" id="J_key" />
			<button class="button" id="J_goSearch">搜索</button>
		</div>
		<table class="cyan" id="tb_memberList">
			<thead>
				<tr>
					<td><input onclick="choice_all(this)" type="checkbox" name="" id="J_selectAll" /></td>
					<td>用户名</td>
					<td>姓名</td>
					<td>工号</td>
					<td>邮箱</td>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
	<div class="modal-footer">
       <a class="btn addMember btn-primary" href="#">添加</a>
       <a class="btn cancel" href="#">取消</a>
    </div>
</div>
<style type="text/css">
	.checkGroupMember .box-item{ width: 100%;}
	.checkGroupMember .top{ overflow: hidden;}
	.searchMember{ margin-bottom: 10px;}
	.searchMember input{ width: 215px;}
	.modal{ width: 600px; display: none; position: absolute; background-clip: padding-box; background-color: #FFFFFF; border: 1px solid rgba(0, 0, 0, 0.3); border-radius: 6px 6px 6px 6px; box-shadow: 0 3px 7px rgba(0, 0, 0, 0.3);}
	.modal .modal-header{ border-bottom: 1px solid #EEEEEE; padding: 9px 15px;}
	.modal .modal-body{ padding: 15px; height: 400px; overflow-y: auto;}
	.modal .modal-footer{ background-color: #F5F5F5; border-radius: 0 0 6px 6px; border-top: 1px solid #DDDDDD; box-shadow: 0 1px 0 #FFFFFF inset; margin-top: 10px; padding: 14px 15px 15px; text-align: right;}
	.btn_close{ float: right; background: none; border: none; padding: 0; text-shadow: 0 1px 0 #FFFFFF; font-size: 20px; line-height: 18px; font-family: "Helvetica Neue",Helvetica,Arial,sans-serif; }
	.isAdmin{ background-color: rgba(51,154,184,.2); border-radius: 5px;}
	.btn_small{ line-height: 16px; margin-top: 4px; margin-right: 10px;}
	.role_tips{ float: right; margin-right: 10px;}
	.role_tips i{ display: inline-block; vertical-align: middle; width: 10px; height: 10px; border: 1px solid #fff; background-color: rgba(51, 154, 184, 0.8); box-shadow: 0 1px 3px rgba(0,0,0,.5); border-radius: 1px;}
	.role_tips label{ vertical-align: middle; margin-left: 5px;}
</style>
<script src="<%=request.getContextPath()%>/resource/js/jquery.menuTree0718.js"></script>
<script>
//过滤数组
function filterTreeData(listData){
	var treeData = [];
	var isNeed = function( menu,group_id){
		if( menu.parent_id == group_id){
			return true;
		}
		return false;
	}
	$.each( listData,function(i,item){
		var currParentId = item.group_id;
		var children = $.grep(listData,function(menu){
			return isNeed(menu,currParentId);
		});
		item.children = children;
		if( item.children.length){
			for( var i = 0, len = listData.length; i < len; i++){
				if( item.parent_id == listData[i].group_id){
					return;
				} 
			}
			treeData.push(item);
			//console.log($.sysop.kit.obj2Str(treeData))
		}
		if( listData.length == 1){
			treeData.push(item);
		}
	})
	//console.log($.sysop.kit.obj2Str(treeData))
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
	})
	if( newarr.length !== 0){
		$.each(newarr,function(i,n){
			arr.push(n);
		})
	}
	return arr;
}
function choice_all(obj){
	if(obj.checked){
		$("input[name='user_check']").attr("checked",true); 
	}else{
		$("input[name='user_check']").attr("checked",false); 
	}
}
$(function(){
	//刷新树
	function reloadTree(){
		loadGroupList();
	}
	//新增节点
	function addItem(param){
		$.getJSON('/admin/group/add.do?'+param,function(data){
			if( data.success){ 
				$.sysop.popup.autoTip('操作成功！');
				reloadTree();
			}
		})
	}
	//删除节点
	function delItem(group_id){
		$.getJSON('/admin/group/delete.do?group_id='+group_id,function(data){
			if( data.success){ 
				$.sysop.popup.autoTip('操作成功！');
				reloadTree();
			} else{
				alert( data.message);
			}
		})
	}
	//编辑树 保存功能
	function editTree(param){
		$.getJSON('/admin/group/update.do?'+param,function(data){
			if( data.success){ 
					$.sysop.popup.autoTip('操作成功！');
					reloadTree();
			}
		})
	}
	

	//浏览组织机构
	var loadGroupList = function(){
		$.getJSON('/admin/group/list.do',function(data){
			if( data.success){
				var list = data.object;
				var html = '';
				var op = '<option value="">请选择</option>';
					if( list.length == 1){
						loadGroupTree(list[0].group_id);
					} else{
						$.each(list,function(n,item){
							$('#J_selectZone').show();
							html += '<option admin="'+item.charge_admin+'" value="'+item.group_id+'">'+item.name+'</option>';
						})
						if( $('#J_sysGroup').find('option').length == 1){
							$('#J_sysGroup').html(op+html);
						}
						loadGroupTree($('body').data('treeID'));
					}
				}
			})
		};
	//加载树
	var loadGroupTree = function(group_id){
		$.getJSON('/admin/group/listOne.do?group_id='+group_id,function(data){
			if( data.success){
				var list = filterTreeData(data.object);
				if( $('#J_sysGroup option:selected').attr('admin') == 1){
					var admin = true;
				} else{
					var admin = false;
				}
				menuOS = new menuTreeNew();
				menuOS.bindData(list);
				menuOS.draw('#menuTreeOS',{unfold:true,checkbox:false,editable:true,link:false,fn_addItem:addItem,fn_delItem:delItem,fn_editItem:editTree,fn_checkMember:checkGroupMember,fn_reloadTree:reloadTree});
				}
				else{
					$('#menuTreeOS').html('');
					alert('请选择！');
				}
		})
	}
	//加载分组
	loadGroupList();
	//加载系统列表
	$('#J_sysGroup').change(function(){
		loadGroupTree($(this).val());
		$('body').data('treeID',$(this).val());
	})
	//从节点加载 查看组员数据 表格 删除 设置管理员
	function checkGroupMember(group_id,tree_charge_admin){
		$('#J_tit').text($('body').data('data').name+'的组员列表');
		$.getJSON('/admin/group/listUser.do?group_id='+group_id,function(data){
			if( data.success){
				var list = data.object;
				var $tbody = $('#tb_groupMember').find('tbody');
				$tbody.html('');
				var html = '';
				if( !list.length){
					$tbody.html('<tr><td style="text-align: center; padding: 20px 0; color: #f60;" colspan="4">暂无数据</td></tr>');
					return;
				}
				$.each(list,function(i,item){
					var charge_admin = item.charge_admin;
					var setAdmin = charge_admin == 0 ? '设为管理员':'取消管理员';
					var adminFlag = charge_admin == 1 ? 'isAdmin' : '';
					if( tree_charge_admin != 0){ //可编辑
						var operate = '<td><a href="#" class="delMember" value="'+item.user_id+'">删除</a> | <a uid="'+item.user_id+'" value="'+ charge_admin +'" href="#" class="setAdmin">'+setAdmin+'</a></td>';
					} else{
						var operate = '<td>管理员才有权限操作</td>';
						$('#J_searchMember').attr('disabled',true);
					}
					html += '<tr class="'+adminFlag+'"><td>'+ item.user_name +'</td><td>'+ item.nick_name +'</td><td>'+ item.email +'</td>'+operate+'</tr>';
				})
				$tbody.html(html);
			}
		})
	}
	//删除组员
	var delMember = function(group_id,user_id){
		$.getJSON('/admin/group/deleteUser.do?group_id='+group_id+'&user_id='+user_id,function(data){
			if( data.success){
				$.sysop.popup.autoTip('删除成功');
				//树当前节点的charge_admin
				var tree_charge_admin = $('body').data('data').charge_admin;
				checkGroupMember(group_id,tree_charge_admin);
			}
		})
	}
	//点击删除链接
	$('.delMember').live('click',function(){
		var group_id = $('body').data('data').group_id;
		var user_id = $(this).attr('value');
		if(confirm('确定删除？')){
			delMember(group_id,user_id);
			return false;
		} else{
			return;
		}
	})
	//设置管理员 取消管理员
	var setAdmin = function(group_id,user_id,charge_admin){
		//树当前节点的charge_admin
		var tree_charge_admin = $('body').data('data').charge_admin;
		if( charge_admin == 1){ //1 取消管理员
			$.getJSON('/admin/group/cancelAdmin.do?group_id='+group_id+'&user_id='+user_id,function(data){
				if( data.success){
					$.sysop.popup.autoTip('取消成功');
					checkGroupMember(group_id,tree_charge_admin);
				}
			})
		} else{ //0 设置管理员
			$.getJSON('/admin/group/setAdmin.do?group_id='+group_id+'&user_id='+user_id,function(data){
				if( data.success){
					$.sysop.popup.autoTip('设置成功');
					checkGroupMember(group_id,tree_charge_admin);
				}
			})
		}
	}
	//点击设置管理员链接
	$('.setAdmin').live('click',function(){
		//var group_id = $('#menuTreeOS').attr('currentgroupId');
		var group_id = $('body').data('data').group_id;
		var user_id = $(this).attr('uid');
		var charge_admin = $(this).attr('value');
		setAdmin(group_id,user_id,charge_admin);
	})
	//搜索未加入的组员 列表 弹出层
	var searchMember = function(group_id,user_name){
		// $.sysop.popup.box('#popup_member');
		if( user_name == undefined){
			var param = 'group_id='+group_id;
		} else{
			var param = 'group_id='+group_id+'&user_name='+user_name;
		}
		$.getJSON('/admin/group/listNotInUser.do?'+param,function(data){
			if( data.success){
				var list = data.object;
				var $tbody = $('#tb_memberList').find('tbody'),html = '';
				$tbody.html('');
				$.each(list,function(i,item){
					html += '<tr><td><input type="checkbox" name="user_check" value="'+ item.user_id +'" /></td><td>'+ item.user_name +'</td><td>'+ item.nick_name +'</td><td>'+ item.work_no +'</td><td>'+ item.email +'</td></tr>'
				})
				$tbody.html(html);
			}
		})
	}
	//搜索组员
	$('#J_searchMember').click(function(){
		var $tbody = $('#tb_memberList').find('tbody').html('');
		$.sysop.popup.box('#popup_member');
		//var group_id = $('#menuTreeOS').attr('currentgroupid');
		var group_id = $('body').data('data').group_id;
		//searchMember(group_id);
		return false;
	})
	//自动完成
	$.sysop.autoComplete.init('#J_key','/admin/userListByUserName.do?user_name=','user_name');
	$('#J_goSearch').click(function(){
		var group_id = $('body').data('data').group_id;
		var user_name = $('#J_key').val();
		searchMember(group_id,user_name);
		return false;
	})
	//绑定回车键搜索
	$.sysop.kit.bindEnterKey('#J_key','#J_goSearch');
	//关闭弹出层
	$('.cancel').click(function(){
		var group_id = $('body').data('data').group_id;
		$.sysop.popup.close('#popup_member');
		checkGroupMember(group_id);
		return false;
	})
	//添加组员
	var addMember = function(group_id,user_ids){
		$.getJSON('/admin/group/addUser.do?group_id='+group_id+'&user_ids='+user_ids,function(data){
			if( data.success){
				$.sysop.popup.autoTip('添加成功');
				if(confirm('添加成功,是否继续添加？')){
					searchMember(group_id);
				}else{
					$.sysop.popup.close('#popup_member');
					checkGroupMember(group_id);
				}
			}
		})
	}
	//点击添加按钮
	$('.addMember').click(function(){
		//var group_id = $('#menuTreeOS').attr('currentgroupId');
		var group_id = $('body').data('data').group_id;
		var user_ids = "";
		$.each($("input[name='user_check']"),function(){
			if(this.checked){
				user_ids = user_ids + this.value + ",";
			}
		})
		if(user_ids == ""){
			alert("请选择要绑定用户的");
			return;
		}
		addMember(group_id,user_ids);
		return false;
	})
})
</script>
</body>
</html>
