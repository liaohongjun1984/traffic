<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>系统分组管理</span></h2>
			<div class="mainContent" id="box_list">
				<!-- 角色管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>系统分组管理</h4>
						<span class="right"><a href="/admin/app_group_add.jspx" class="button" style="line-height:18px">添加系统分组</a></span>
					</div>
					<div class="cont" >
						<table class="cyan tb-actorList">
							<thead>
								<tr>
									  
									<td>系统分组</td>            
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
//载入未完成的包
function searchData(){
	var $box=$('#box_list').show();
	$.ajax({
        type: "get",
        async: false,
        url: '/admin/appGroupList.do',
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
	                  <td><div>'+this.name+'</div></td>\
	                  <td><div><a href="/admin/app_group_add.jspx?app_group_id='+this.app_group_id+'">修改</a>|<a href="javascript:void();" onclick="appGroupRemove(\''+this.app_group_id+'\');">删除</a></div></td>\
	          </tr>');
		});
	}
}
searchData();
//修改应用系统的启用与禁用标识
function appGroupRemove(app_group_id) {
	var req='app_group_id='+app_group_id;
	$.getJSON('/admin/appGroupRemove.do',req,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		alert("删除成功!");
		searchData();
	});			
}
</script>
</body>
</html>