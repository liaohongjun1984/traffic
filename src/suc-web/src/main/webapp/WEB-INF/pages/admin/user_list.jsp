<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>

	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right" id="box_list">
			<h2 id="mainTitle" class="mainTitle"><span>用户管理</span></h2>
			<div class="mainContent">
				<!-- 用户管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>用户列表</h4><span class="right count"></span>
					</div>
					<div class="cont">
						<div class="action-bar">
							<span>用户名称：</span>
							<input type="search" placeholder="用户名称" name="user_name" id="user_name" />
							<span>姓名：</span>
							<input type="search" placeholder="姓名" name="nick_name" id="nick_name" />
							<input type="button" class="button" id="search_user" value="搜索" onclick="searchData()" />
							&nbsp; <span style="background-color:#fff; border:#aca 1px solid;">&nbsp;&nbsp;</span> 正常状态
							&nbsp; <span style="background-color:#fee; border:#aca 1px solid;">&nbsp;&nbsp;</span> 冻结状态
            				<a href="/admin/user_add.jspx" class="button fr">添加用户</a>
                    	</div>
						<table class="cyan tb-actorList">
							<thead>
								<tr>
									<td>序号</td>
									<td>用户名称</td>            
									<td>姓名</td>
									<td>部门</td>
									<td>联系电话</td>
									<td>邮箱</td>
									<td class="op" style="text-align:center">操作</td>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
						<div class="paginationbar" id="paginationbar">
						</div>
						<!--分页导航-->
						<div class="displayNum" id="displayNum">
						</div>
						<!--每页显示数目导航-->
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
//自动完成
$.sysop.autoComplete.init('#user_name','/admin/userListByUserName.do?user_name=','user_name');
$.sysop.autoComplete.init('#nick_name','/admin/userListByNickName.do?nick_name=','nick_name');
//搜索绑定enter
$('.action-bar input[type="search"]').each(function() {
	$.sysop.kit.bindEnterKey('#' + this.id, searchData);
});

function searchData(page,disR){
	var $box=$('#box_list').show();
	var fn=arguments.callee;
	var param = 'user_name='+$('#user_name').val()+'&nick_name='+$('#nick_name').val();
	var req   =  param+'&page='+(page||1)+'&displayRecord='+(disR=disR||20);//默认20
	$.ajax({
        type: "get",
        async: false,
        url: '/admin/userList.do',
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
		var i = 1;
		$.each(list,function(){
			var bg = ' bgColor="#fff" ';
			if(this.status==2){
				bg=' bgColor="#fee" ';
			}
			if(this.status==3){
				bg=' bgColor="#fff" ';
			}
		/*	$tbody.append('<tr' + bg + '>\
	                  <td><div>'+this.user_name+'</div></td>\
	                  <td><div>'+this.nick_name+'</div></td>\
	                  <td><div>'+this.work_no+'</div></td>\
	                  <td><div>'+checkDement(this.department)+'</div></td>\
	                  <td><div>'+filterMobileNo(this.mobile_no)+'</div></td>\
	                  <td><div>'+(this.admin==1?"是":"否")+'</div></td>\
	                  <td><div>\
	                  <a href="/admin/user_view.jspx?user_name='+this.user_name+'">查看</a>|\
	                  <a href="/admin/user_add.jspx?user_name='+this.user_name+'">修改</a>|\
	                  <a href="/admin/update_user_pwd.jspx?user_name='+this.user_name+'">密码重置</a>|\
	                  <a href="javascript:void(0);" onclick="deleteUserById(\''+this.user_id+'\')">删除</a>|\
	                  <a href="javascript:void(0);" onclick="setAdmin(\''+this.user_name+'\','+this.admin+')">'+(this.admin==1?"取消管理员":"设为管理员")+'</a>|\
	                  <a href="/admin/user_role.jspx?user_id='+this.user_id+'">角色关联</a></div></td>\
	          </tr>');*/

              $tbody.append('<tr' + bg + '>\
            		  <td><div>'+i+'</div></td>\
	                  <td><div>'+this.user_name+'</div></td>\
	                  <td><div>'+this.nick_name+'</div></td>\
	                  <td><div>'+this.group_name+'</div></td>\
	                  <td><div>'+filterMobileNo(this.mobile_no)+'</div></td>\
	                  <td><div>'+this.email+'</div></td>\
	                  <td><div>\
	                  <a href="/admin/user_add.jspx?user_name='+this.user_name+'">修改</a>|\
	                  <a href="javascript:czpasswd(\''+this.user_name+'\')">密码重置</a>|\
	                  <a href="javascript:void(0);" onclick="deleteUserById(\''+this.user_id+'\')">删除</a>|\
	                  <a href="javascript:void(0);" onclick="setAdmin(\''+this.user_name+'\','+this.admin+')">'+(this.admin==1?"取消管理员":"设为管理员")+'</a>|\
	                  <a href="/admin/user_role.jspx?user_id='+this.user_id+'">角色关联</a></div></td>\
	          </tr>');   
	          i = i + 1;
		});
		$box.find('.count').html("记录数("+count+")");
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
searchData();

function setAdmin(user_name,admin){
	var realAdmin = (admin==1?2:1);	
	$.getJSON('/admin/setAdmin.do',"user_name="+user_name+"&admin="+realAdmin,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		searchData();
	});		
}

function deleteUserById(user_id){
	if(!confirm('确定删除此用户？')) return false;
	$.getJSON('/admin/deleteUserById.do',"user_id="+user_id,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		searchData();
	});		
}

function czpasswd(user_name){
	$.getJSON('/admin/updateUserPwd.do',"username="+user_name,function(json){
		if(!json.success) {
			//alert(json.message);
			showDialog(json.message);
			return;
		}else{
			//alert(json.message);
			showDialog(json.message);
		}
	});	
}

//过虑显示联系电话
function filterMobileNo(mobile_no){
	if(mobile_no==null){
		return "&nbsp;";
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

function showDialog(msg){
	var dialog = jDialog.alert(msg,{},{
		showShadow: false,// 不显示对话框阴影
		buttonAlign : 'center',
		events : {
			show : function(evt){
				var dlg = evt.data.dialog;
			},
			close : function(evt){
				var dlg = evt.data.dialog;
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
</script>
</body>
</html>