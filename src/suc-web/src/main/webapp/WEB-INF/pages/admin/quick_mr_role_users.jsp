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
						<h4>角色用户管理</h4>
					</div>
					<div class="cont" >
						<form id="f_1">
						<div class="action-bar">
						<table class="cyan tb-actorList">
							<tr>
							<th><span><em class="em">*</em>用户名：</span></th>
							<td><input type="search" id="user_name" name="user_name" class="validate[required] long" placeholder="用户名,多用户以逗号分隔，例如dw_zhangsan,dw_lisi" /></td>
							</tr>
							<tr>
							<th><span>操作类型：</span></th>
							<td><input type="radio" name="op_type" value="add" checked />添加&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" name="op_type" value="del" />删除</td>
							</tr>
							<tr>
							<th></th>
							<td>
							<input type="button" class="button" id="search_user" value="操作" onclick="quick_role_user();"/>
							</td>
							</tr>
							<tr>
							<th>
							<span>操作结果</span>
							</th>
							<td>
							<textarea rows="" cols="80" placeholder="操作结果" id="result"></textarea>
							</td>
							</tr>
                    	</table>
                    	</div>
                    	
                    	 </form>
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



$("#f_1").validationEngine();
function add_role_user(){
	window.location.href = "/admin/add_role_users.jspx?id="+id+"&name="+name;
}

function quick_role_user(){
	//if(!$("#f_1").validationEngine('validate'))return;
	var req=$('#f_1').serialize(); 
	req = req + "&role_id="+id;
	$.getJSON('/admin/qucikRoleUser.do',req,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		var list = json.object;
		alert("修改成功，结果请参看结果列表")
		var html = "";
		 $.each(list,function(n,value) { 
			html = html + value +"\n";
		});
		$('#result').val(html)	
	});		
}

</script>
</body>
</html>
