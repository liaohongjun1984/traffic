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
						<h4>角色待添加用户列表</h4><span class="right">记录数(<span class="count">0</span>)</span>
					</div>
					<div class="cont" >
						<form id="f_1">
						<div class="action-bar">
						
							<span>用户名：</span>
							<input type="search" id="user_name" placeholder="用户名" />
							<span>姓名：</span>
							<input type="search" id="nick_name" placeholder="姓名" />
							<input type="button" class="button" id="search_user" value="搜索" />
							<a onclick="add_users()" class="button fr">添加</a>
                    	</div>
                    	 </form>
						<table class="cyan tb-actorList">
							<thead>
								<tr>
									<td><input type="checkbox" onclick="choice_all(this);"/></td>
									<td>用户名</td>            
									<td>姓名</td>
									<td>工号</td>
									<td>部门</td>
									<td>联系电话</td>
								</tr>
							</thead>
							<tbody>
								
							</tbody>
						</table>
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
$('#box_list').find('.role_info').html(name);
//搜索绑定enter
$('.action-bar input[type="search"]').each(function() {
	$.sysop.kit.bindEnterKey('#' + this.id, searchData);
});

var id=$.sysop.kit.getUrlValue('id');
var name=$.sysop.kit.getUrlValue('name');
function searchData(page,disR){
	var $box=$('#box_list').show();
	var fn=arguments.callee;
	var param = 'role_id='+id+'&user_name='+$('#user_name').val()+"&nick_name="+$('#nick_name').val();
	var req   =  param;//默认20
	$.ajax({
        type: "get",
        async: false,
        url: '/admin/getNotUserByRole.do',
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
		var list=json.object,count=list.length;
		var $tbody=$box.find('tbody').html('');
		$.each(list,function(){
			$tbody.append('<tr>\
					 <td><div><input type="checkbox" name="user_check" id="check_user" value='+this.user_id+'></div></td>\
	                  <td><div>'+this.user_name+'</div></td>\
	                  <td><div>'+this.nick_name+'</div></td>\
	                  <td><div>'+this.work_no+'</div></td>\
	                  <td><div>'+checkDement(this.department)+'</div></td>\
	                  <td><div>'+this.mobile_no+'</div></td>\
	          </tr>');
		});
		$box.find('.count').html(count);
	}
}

searchData();
$('#search_user').click(function(){searchData();});


function choice_all(obj){
	if(obj.checked){
		$("input[name='user_check']").attr("checked",true); 
	}else{
		$("input[name='user_check']").attr("checked",false); 
	}
}

function add_users(){
	var user_ids = "";
	$.each($("input[name='user_check']"),function(){
		if(this.checked){
			user_ids = user_ids + this.value + ",";
		}
	});
	if(user_ids == ""){
		alert("请选择要绑定用户的");
		return;
	}
	user_ids = user_ids.substring(0,user_ids.length - 1);
	var req = "role_id="+id+"&user_ids="+user_ids;
	$.post('/admin/bindRoleUsers.do',req,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		if(confirm('添加成功,是否继续添加？')){
			searchData();
		}else{
			window.location.href="/admin/role_users.jspx?id="+id+"&name="+name;
		}
		
	});		
}




</script>
</body>
</html>
