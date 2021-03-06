<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resource/js/url_show.js"></script>
<script src="<%=request.getContextPath()%>/resource/admin/css/url_show.css"></script>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right" id="box_list">
			<h2 id="mainTitle" class="mainTitle"><span>审核记录列表</span></h2>
			<div class="mainContent">
				<!-- 用户管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>审核记录列表</h4><span class="right count"></span>
					</div>
					<div class="cont">
						<div class="action-bar">
							<span>车牌号：</span>
							<input type="search" placeholder="车牌号" name="car_num" id="car_num" />
							<input type="button" class="button" id="search_user" value="搜索" onclick="searchData()" />
                    	</div>
						<table class="cyan tb-actorList">
							<thead>
								<tr>
									<td>序号</td>
									<td>证件类型</td>
									<td>汽车类型</td>    
									<td>图片</td>        
									<td>车牌号</td>
									<td>路口</td>
									<td>违反行为</td>
									<td>违法时间</td>
									<td>标准值</td>
									<td>实测值</td>
									<td>公里数</td>
									<td>地点米数</td>
									<td>审核状态</td>
									<td>处理人</td>
									<td>处理时间</td>
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

//搜索绑定enter
$('.action-bar input[type="search"]').each(function() {
	$.sysop.kit.bindEnterKey('#' + this.id, searchData);
});

function searchData(page,disR){
	var $box=$('#box_list').show();
	var fn=arguments.callee;
	var param = 'car_num='+$('#car_num').val();
	var req   =  param+'&page='+(page||1)+'&displayRecord='+(disR=disR||20);//默认20
	
	$.ajax({
        type: "get",
        async: false,
        url: '/traffic/tpDealLogs/tpDealLogsList.do',
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
			
			var file_status = "";
			if(this.file_status == 0){
				file_status = "确认匹配";
			}else if(this.file_status == 1){
				file_status = "确认不匹配";
			}else if(this.file_status == 2){
				file_status = "无效";
			}
			
			var file_addr = "";
			var address = this.file_addr;
			$.each(address,function(i,a){
				file_addr += '<img onclick=url_show("'+a+'") src='+a+' width="80" height="80">';
			});
			
			//标准值
			var sp_standard = this.sp_standard;;
			if(sp_standard == null||sp_standard == ""){
				sp_standard = "空";
			}
			//实测值
			var sp_measured = this.sp_measured;
			if(sp_measured==null||sp_measured==""){
				sp_measured = "空";
			}
			//公里数
			var sp_kilometers = this.sp_kilometers;
			if(sp_kilometers==null||sp_kilometers==""){
				sp_kilometers = "空";
			}
			//实测米数
			var sp_place_metre = this.sp_place_metre;
			if(sp_place_metre==null||sp_place_metre==""){
				sp_place_metre = "空";
			}

              $tbody.append('<tr' + bg + '>\
            		  <td><div>'+i+'</div></td>\
	                  <td><div>公安牌证件</div></td>\
	                  <td><div>'+this.car_type_name+'</div></td>\
	                  <td><div>'+file_addr+'</div></td>\
	                  <td><div>'+this.car_num+'</div></td>\
	                  <td><div>'+this.road_name+'</div></td>\
	                  <td><div>'+this.violation_action_name+'</div></td>\
	                  <td><div>'+this.deal_time+'</div></td>\
	                  <td><div>'+sp_standard+'</div></td>\
	                  <td><div>'+sp_measured+'</div></td>\
	                  <td><div>'+sp_kilometers+'</div></td>\
	                  <td><div>'+sp_place_metre+'</div></td>\
	                  <td><div>'+file_status+'</div></td>\
	                  <td><div>'+this.deal_user_name+'</div></td>\
	                  <td><div>'+this.create_time+'</div></td>\
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

</script>
</body>
</html>