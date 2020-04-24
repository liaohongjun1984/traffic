<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>参数设置</span></h2>
			<div class="mainContent" id="box_list">
				<!-- 角色管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>参数设置</h4>
					</div>
					<div class="cont" >
						<table class="cyan tb-actorList">
							<thead>
								<tr>
									<td>参数ID</td>
									<td>参数名称</td>    
									<td>参数值</td>               
									<td>参数描述</td>
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

window.onload=searchData();//自动加载js
//载入未完成的包
function searchData(){
	var $box=$('#box_list').show();
	$.ajax({
        type: "get",
        async: false,
        url: '/admin/getParamList.do',
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
			$tbody.append('<tr' + '' + '>\
					<td><div>'+this.id+'</div></td>\
					   <td><div>'+this.dicKey+'</div></td>\
	                  <td><div>'+this.value+'</div></td>\
	                  <td><div>'+this.name+'</div></td>\
	                  <td><div><a href="/admin/param_update.jspx?param_id='+this.id+'">修改</a></div></td>\
	          </tr>');
		});
	}
}

</script>
</body>
</html>