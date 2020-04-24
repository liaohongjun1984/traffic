<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>角色管理</span></h2>
			<div class="mainContent" id="box_list">
				<!-- 角色管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>角色列表</h4><span class="right">记录数(<span class="count">0</span>)</span>
					</div>
					<div class="cont" >
						<form id="f_1">
						<div class="action-bar">
						
							<span>角色名称：</span>
							<input type="search" id="role_name" placeholder="角色名称" />
							<span>系统名称：</span>
							<select id="app_id">
								
							</select>
							<input type="button" class="button" id="search_role" value="搜索" />
            				<a href="/admin/role_op.jspx" class="button fr">添加角色</a>
                    	</div>
                    	 </form>
						<table class="cyan tb-actorList">
							<thead>
								<tr>
									<td>角色ID</td>  
									<td>角色名称</td>            
									<td>备注</td>
									<td>所属系统</td>
									<td class="op">操作</td>
								</tr>
							</thead>
							<tbody>
								
							</tbody>
						</table>
						
						<div class="paginationbar"></div><!--分页导航-->
          				<div class="displayNum"></div><!--每页显示数目导航-->
          				<div class="clear"></div>
					  </div>
					</div>
				<!-- 角色管理 end -->
			</div>
		</div>
		<!-- right end -->
	</div>
	<!-- mani end -->
	<div class="footer clearfix"></div>
	<div class="pop-cont popConfirm" id="popConfirm" style="display: none;">
	<dl>
		<dt>复制角色<a href="#popConfirm" class="close"></a></dt>
		<dd>
			<div class="cont">
				<div class="cont_t">
					<div class="copy_actor">
						<p class="red">同一系统复制用户和菜单权限，不同系统只复制用户</p>
						<input type="hidden" id="copy_role_id" value=""/>
						<input type="hidden" id="copy_app_id" value=""/>
						<div class="field">
							<span class="sysList" style="visiblity: hidden;">
									<select name="sysList" id="sysList">
							
									</select>
								</span>
							<span class="field_title">复制到：</span>
							<div class="field_content">
								<input type="radio" name="radio" id="r1" checked="checked" /><label for="r1">本系统</label>
								<input type="radio" name="radio" id="r2" /><label for="r2">其他系统</label>
								
							</div>
						</div>
						<div class="field">
							<span class="field_title">名称：</span>
							<div class="field_content"><input value="管理员" id="J_actorName" type="text" /></div>
						</div>
					</div>
				</div>
				<div class="btn">
					<input type="button" value="确认" class="ok button" alt="#popConfirm" onclick="copyRoleSave()"/>
					<input type="button" value="取消" class="close button" alt="#popConfirm" />
					</div>
				</div>
			</dd>
		</dl>
	</div>
	<style>
		.sysList{ float: right; margin-left: 10px;}	
	</style>
</div>
<script>
$.sysop.autoComplete.init('#role_name','/admin/roleListByName.do?role_name=','role_name');
//搜索绑定enter
$('.action-bar input[type="search"]').each(function() {
	$.sysop.kit.bindEnterKey('#' + this.id, searchData);
});

$(function(){
	//复制角色
	pre_add();
	$.getJSON('/admin/getAppList.do',function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		var appInfo = $("#app_id");
		appInfo.append("<option value=''>请选择</option>");
		$.each(json.object,function(){
			appInfo.append("<option value='"+this.app_id+"'>"+this.cn_name+"</option>");
		});
	});		
})

//载入未完成的包
function searchData(page,disR){
	var $box=$('#box_list').show();
	var fn=arguments.callee;
	var param = 'role_name='+$('#role_name').val()+'&app_id='+$('#app_id').val();
	var req   =  param+'&page='+(page||1)+'&displayRecord='+(disR=disR||20);//默认20
	$.ajax({
        type: "get",
        async: false,
        url: '/admin/roleList.do',
        data: req,
        dataType: "json",
        cache: false,
        success: dealData
    });
	function dealData(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		var count=json.object.count,list=json.object.lists,p=json.object.page,pCount=json.object.pageCount;
		var $tbody=$box.find('tbody').html('');
		$.each(list,function(){
			$tbody.append('<tr>\
										<td><div>'+this.role_id+'</div></td>\
	                  <td><div>'+this.role_name+'</div></td>\
	                  <td><div>'+this.notes+'</div></td>\
	                  <td><div>'+this.cn_name+'('+this.name+')</div></td>\
	                  <td><div><a href="/admin/role_op.jspx?type=update&id='+this.role_id+'">修改</a>|<a href="javascript:void(0);" onclick="deleteRole('+this.role_id+')">删除</a>|<a class="J_copyActor" href="javascript:void(0);" onclick="copyRole('+this.role_id+','+this.app_id+',\''+this.role_name+'\');">复制</a>|\
	                  <a href="/admin/role_menu.jspx?id='+this.role_id+'&name='+this.role_name+'">修改权限</a>|<a href="/admin/role_users.jspx?id='+this.role_id+'&name='+this.role_name+'">拥有用户</a></div></td>\
	          </tr>');
		});
		$box.find('.count').html(count);
		//分页
		var $pag=$box.find('.paginationbar'),$dis=$box.find('.displayNum');
		$.sysop.pagination.init($pag,p,pCount,10,function(num){
			fn(num,disR);
		});
		//显示数目
		$.sysop.pagination.displayNum($dis,disR,function(){
			fn(1,this.innerHTML.slice(0,-1));
		});
	}
}
//修改应用系统的启用与禁用标识
function deleteRole(roleId) {
	var req='roleId='+roleId;
	$.getJSON('/role!delete.do',req,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		alert("删除成功!");
		searchData();
	});			
}
searchData();
$('#search_role').click(function(){searchData();});

function add() {
	window.location.href="/role!roleInfo.action";
}
$('#add').click(function(){add();});

function deleteRole(role_id){
	if(!confirm('确认删除？')) return;
	$.getJSON('/admin/deleteRole.do?role_id='+role_id,function(json){
		if(!json.success){
			alert(json.message);
		}else{
			alert("删除成功!");
			searchData();
		}
	});	
}

function copyRole(role_id,app_id,role_name){
	$('#r1').attr('checked',true);
	$('.sysList').hide();
	$("#J_actorName").val(role_name + '_copy');
	$("#copy_role_id").val(role_id);
	$("#copy_app_id").val(app_id);
	$.getJSON('/admin/getAppList.do',function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		var sysList = $("#sysList");
		sysList.empty();
		sysList.append("<option value=''>请选择</option>");
		$.each(json.object,function(){
			if(app_id != this.app_id)
				sysList.append("<option value='"+this.app_id+"'>"+this.cn_name+"</option>");
		});
	});		
	$.sysop.popup.box('#popConfirm');
	$('#J_actorName').select();
	$('.field_content input').click(function(){
		if( $('#r2').is(':checked')){
			$('.sysList').show();
		} else{
			$('.sysList').hide();
		}
	})
}

function copyRoleSave(){
	var same_app = "true";
	var app_id = $("#copy_app_id").val();
	if( $('#r2').is(':checked')){
		same_app = "false";
		app_id = $('#sysList').val();
		if($('#sysList').val()==''){
			alert("请选择要复制的系统");
			return false;
		}
	}
	if(!confirm('确认复制？')) return;
	var req = "copy_role_id="+$("#copy_role_id").val()+"&role_name="+$("#J_actorName").val();
	req = req + "&app_id="+app_id+"&same_app="+same_app;
	$.getJSON('/admin/copyRoleUser.do',req,function(json){
		if(!json.success){
			alert(json.message);
		}else{
			alert("复制成功!");
			$.sysop.popup.close('#popConfirm');
			searchData();
		}
		
	});	
}
function pre_add(){
	var id=$.sysop.kit.getUrlValue('id');
	
}
</script>
</body>
</html>
