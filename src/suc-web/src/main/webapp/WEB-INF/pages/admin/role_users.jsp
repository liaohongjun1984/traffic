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
						<h4>角色(<span class="role_info"></span>)用户列表</h4><span class="right">记录数(<span class="count">0</span>)</span>
					</div>
					<div class="cont" >
						<form id="f_1">
						<div class="action-bar">
						
							<span>用户名：</span>
							<input type="search" id="user_name" placeholder="用户名" />
							<span>姓名：</span>
							<input type="search" id="nick_name" placeholder="姓名" />
							<input type="button" class="button" id="search_user" value="搜索" />
							<div class="fr">
            				<a class="button" onclick="history.back()">« 返回<a/>|<a onclick="deleteRoleUser(0)" class="button">清理全部用户</a>|<a onclick="add_role_user()" class="button">添加用户</a>|<a onclick="quick_mr_role_user()" class="button">快速管理用户</a>
                    		</div>
                    	</div>
                    	 </form>
						<table class="cyan tb-actorList">
							<thead>
								<tr>
									<td>用户名</td>
									<td>姓名</td>
									<td>工号</td>
									<td>部门</td>
									<td>联系电话</td>
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
</div>
<script>
var id=$.sysop.kit.getUrlValue('id');
var name=$.sysop.kit.getUrlValue('name');
$('#box_list').find('.role_info').html(name);

//搜索绑定enter
$('.action-bar input[type="search"]').each(function() {
	$.sysop.kit.bindEnterKey('#' + this.id, searchData);
});

//载入未完成的包
function searchData(page,disR){
	var $box=$('#box_list').show();
	var fn=arguments.callee;
	var param = 'role_id='+id+'&user_name='+$('#user_name').val()+"&nick_name="+$('#nick_name').val();
	var req   =  param+'&page='+(page||1)+'&displayRecord='+(disR=disR||20);//默认20
	$.ajax({
        type: "get",
        async: false,
        url: '/admin/getUserByRole.do',
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
	                  <td><div>'+this.user_name+'</div></td>\
	                  <td><div>'+this.nick_name+'</div></td>\
	                  <td><div>'+this.work_no+'</div></td>\
	                  <td><div>'+checkDement(this.department)+'</div></td>\
	                  <td><div>'+filterMobileNo(this.mobile_no)+'</div></td>\
	                  <td><div><a href="javascript:void(0);" onclick="deleteRoleUser('+this.user_id+')">删除</a></div></td>\
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
//过虑显示联系电话
function filterMobileNo(mobile_no){
	if(mobile_no==null){
		return "&nbsp;"
	}
	if(mobile_no=="null"){
		return "&nbsp;";
	}
	if(mobile_no==0){
		return "&nbsp;";
	}
	if(mobile_no=="0"){
		return "&nbsp;";
	}
	return mobile_no;
}
//修改应用系统的启用与禁用标识
function deleteRole(roleId) {
	var req='roleId='+roleId;
	$.getJSON('/role!delete.action',req,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		alert("删除成功!");
		searchData();
	});			
}
searchData();
$('#search_user').click(function(){searchData();});

function deleteRoleUser(user_id){
	if(!confirm('确认删除？')) return;
	$.getJSON('/admin/deleteRoleUser.do?role_id='+id+'&user_id='+user_id,function(json){
		if(!json.success){
			alert(json.message);
			return;
		}
		alert("删除成功!");
		searchData();
	});	
}

function quick_mr_role_user(){
	window.location.href = "/admin/quick_mr_role_users.jspx?id="+id+"&name="+name;
}

function add_role_user(){
	window.location.href = "/admin/add_role_users.jspx?id="+id+"&name="+name;
}

</script>
</body>
</html>
