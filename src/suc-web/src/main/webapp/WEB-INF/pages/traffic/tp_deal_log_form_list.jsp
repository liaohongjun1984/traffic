<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resource/js/url_show.js"></script>
<script src="<%=request.getContextPath()%>/resource/admin/css/url_show.css"></script>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right" id="box_list">
			<h2 id="mainTitle" class="mainTitle"><span>报表统计列表</span></h2>
			<div class="mainContent">
				<!-- 用户管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>报表统计列表</h4><span class="right count"></span>
					</div>
					<div class="cont">
						<div class="action-bar">
							<span>日期：</span>
							<select id="timeType" name="timeType">
								<option value="1">创建时间</option>
								<option value="2">违法时间</option>
							</select>
							<input type="text" placeholder="开始时间" name="keyword" id="beginTime" class="beginTime" onclick="$.calendar.Show({format:'yyyy-MM-dd'})" />
							<input type="text" placeholder="结束时间" name="keyword" id="endTime" class="endTime" onclick="$.calendar.Show({format:'yyyy-MM-dd'})" />&nbsp;
							<input type="button" class="button" id="search_user" value="搜索" onclick="searchData()" />
                    	</div>
						<table class="cyan tb-actorList">
							<thead>
								<tr>
									<td>序号</td>
									<td>处理人</td>
									<td>路口</td>
									<td>违反行为</td>
									<td>违反次数</td>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
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

//搜索绑定enter
$('.action-bar input[type="search"]').each(function() {
	$.sysop.kit.bindEnterKey('#' + this.id, searchData);
});

function searchData(page,disR){
	var $box=$('#box_list').show();
	var fn=arguments.callee;
	var param = 'timeType='+$('#timeType').val()+'&beginTime='+$('#beginTime').val()+'&endTime='+$('#endTime').val();
	var req   =  param+'&page='+(page||1)+'&displayRecord='+(disR=disR||20);//默认20
	$.ajax({
        type: "get",
        async: false,
        url: '/traffic/tpDealLogs/tpDealLogsForm.do',
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
		list=json.object.list;
		var $tbody=$box.find('tbody').html('');
		var i = 1;
			$.each(list,function(){
			var roadInfos = this.roadInfo;
				$.each(roadInfos,function(){
				var roadName = this.roadName;
				 delLogList=this.delLogList;
					$.each(delLogList,function(){
		              $tbody.append('<tr>\
		            		  <td><div>'+i+'</div></td>\
			                  <td><div>'+this.deal_user_name+'</div></td>\
			                  <td><div>'+roadName+'</div></td>\
			                  <td><div>'+this.violation_action_name+'</div></td>\
			                  <td><div>'+this.delLogNum+'</div></td>\
			          </tr>');   
			          i = i + 1;
					});
				});
		});
	}	
}
searchData();

</script>
</body>
</html>