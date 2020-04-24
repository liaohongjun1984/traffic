<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>用户拥有角色列表</span></h2>
			<div class="mainContent" id="box_list">
				<!-- 角色管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>用户拥有角色列表</h4><span class="right"></span>
					</div>
					<div class="cont" >
						<form id="f_1">
						<div class="action-bar">
							<span>系统名称：</span>
							<select id="app_id">
							</select>
                    	</div>
                    	 </form>
						<table class="cyan tb-actorList">
							<thead>
								<tr>
									<td>是否选择</td>    
									<td>角色名称</td>            
									<td>备注</td>
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
//载入未完成的包
function searchData(app_id){
	var $box=$('#box_list').show();
	var app_id  = $("#app_id").val();
	var user_id = $.sysop.kit.getUrlValue('user_id');
	var param   = 'app_id='+app_id+'&user_id='+user_id;
	
	if(!app_id){
		alert("请选择系统名称!");
		return ;
	}
	$.ajax({
        type: "get",
        async: false,
        url: '/admin/getUserRole.do',
        data: param,
        dataType: "json",
        cache: false,
        success: dealData
    });
	function dealData(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		var list=json.object;
		var $tbody=$box.find('tbody').html('');
		$.each(list,function(){
			$tbody.append('<tr>\
	                  <td><div><input name="role_id" value="'+this.role_id+'" type="checkbox" '+(this.checked?"checked":"")+' onclick="changeRole(this);"/></div></td>\
	                  <td><div>'+this.role_name+'</div></td>\
	                  <td><div>'+this.notes+'</div></td>\
	          </tr>');
		});
	}
}
//下拉框更新事件 
$("#app_id").change(searchData);

function changeRole(obj) {
	var checked = $(obj).attr("checked");
	var role_id = $(obj).val();
	var user_id = $.sysop.kit.getUrlValue('user_id');
	
	var param = {};
	param["checked"]=(checked?true:false);
	param["role_id"]=role_id;
	param["user_id"]=user_id;
	
	$.getJSON('/admin/userRole.do',param,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		searchData();
	});	
}
$(function (){
	$.getJSON('/app/listUseApp.do',function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		var appInfo = $("#app_id");
		$.each(json.object,function(){
			appInfo.append("<option value='"+this.app_id+"'>"+this.cn_name+"</option>");
		});
		searchData();
	});			
});
</script>
</body>
</html>