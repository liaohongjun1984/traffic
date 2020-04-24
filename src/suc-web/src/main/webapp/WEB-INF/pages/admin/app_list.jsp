<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>系统管理</span></h2>
			<div class="mainContent" id="box_list">
				<!-- 角色管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>系统管理</h4>
					</div>
					<div class="cont" >
						<form id="f_1">
						<div class="action-bar">
							<span>系统名称：</span>
							<select id="app_group_id" name="app_group_id">
							</select>
							<span>系统状态：</span>
							<select id="status" name="status">
								<option value="">选择全部</option>
								<option value="1">可用</option>
								<option value="2">不可用</option>
							</select>
							&nbsp; <span style="background-color:#fff; border:#aca 1px solid;">&nbsp;&nbsp;</span> 可用的系统
							&nbsp; <span style="background-color:#fee; border:#aca 1px solid;">&nbsp;&nbsp;</span> 不可用的系统
							<a  style="margin-top: -3px;margin-left:5px" class="button fr" onclick = "updateSystem()" >更新系统</a>
							<a href="/admin/app_add.jspx" style="margin-top: -3px;" class="button fr">添加系统</a>
                    	</div>
                    	 </form>
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

function updateSystem(){
	$.ajax({
		type: 'POST',
		url: '/admin/updateSystem.do',
		success: function(json) {
			alert(json.message);
		}
	});
/* 	
	$.ajax({
		type: 'GET',
		url: '/traffic/tpFilterFile/tpFilterFileUpdateSome.do',
		success:function(){
			alert("数据调用更新成功！");
		}
	});  */
}


//载入未完成的包
function searchData(){
	var $box=$('#box_list').show();
	var app_group_id  = $("#app_group_id").val();
	var status        = $("#status").val();
	var param         = 'app_group_id='+app_group_id+'&status='+status;
	
	$.ajax({
        type: "get",
        async: false,
        url: '/admin/getAppList.do',
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
			var bg = this.status == 1 ? '' : ' style="background-color:#fee"';
			$tbody.append('<tr' + bg + '>\
					   <td><div>'+this.app_id+'</div></td>\
	                  <td><div>'+this.group_name+'</div></td>\
	                  <td><div>'+this.cn_name+'</div></td>\
	                  <td><div>'+this.name+'</div></td>\
	                  <td><div>'+this.descript+'</div></td>\
	                  <td><div><a href="/admin/app_add.jspx?app_id='+this.app_id+'">修改</a>|<a href="javascript:void();" onclick="disableAndAble(\''+this.app_id+'\',\''+this.status+'\');">'+(this.status==1?"停用":"启用")+'</a></div></td>\
	          </tr>');
		});
	}
}

function disableAndAble(app_id,status){
	var msg = status==1 ? "确定要停用该系统吗？" : "确定要启用该系统吗？";
	if(!confirm(msg)){
		return ;
	}
	$.getJSON('/admin/disableAndAble.do',"app_id="+app_id+"&status="+status,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		searchData();
	});		
}
//下拉框更新事件 
$("#app_group_id").change(searchData);
$("#status").change(searchData);

$(function (){
	$.getJSON('/admin/appGroupList.do',function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		var appInfo = $("#app_group_id");
		appInfo.append("<option value='0'>选择全部</option>");
		$.each(json.object,function(){
			appInfo.append("<option value='"+this.app_group_id+"'>"+this.name+"</option>");
		});
		searchData();
	});			
});


</script>
</body>
</html>