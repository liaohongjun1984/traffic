<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right" id="box_list">
			<h2 id="mainTitle" class="mainTitle"><span>消息查询</span></h2>
			<div class="mainContent">
				<!-- 用户管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>消息列表</h4><span class="right count"></span>
					</div>
					<div class="cont">
						<div class="action-bar">
				      		<label for="J_sysGroup">消息类型：</label>
				      		<select id="queue_type" name="queue_type">
				      			<option value="0">全部</option>
				      			<option value="101">Email</option>
				      			<option value="104">短信</option>
				      		</select>
							<span>&nbsp;&nbsp;&nbsp;&nbsp;操作时间：</span>
							<input type="text" placeholder="起始时间" name="start_time" id="start_time" onclick="$.calendar.Show({format:'yyyy-MM-dd HH:mm'})" readonly />&nbsp;到
							<input type="text" placeholder="结束时间" name="end_time" id="end_time" onclick="$.calendar.Show({format:'yyyy-MM-dd HH:mm'})" readonly />
							<input type="button" class="button" id="search_user" value="搜索" onclick="searchData()" />
                    	</div>
						<table class="cyan tb-actorList">
							<thead>
								<tr>
									<td style="width:60px;">流水号</td>            
									<td style="width:60px;">收件人</td>
									<td style="width:60px;">抄送</td>
									<td style="width:60px;">类型</td>
									<td style="width:160px;">序列号</td>
									<td style="width:160px;">标题</td>
									<td style="width:100px;">结果</td>
									<td style="width:120px;">时间</td>
									<td style="width:60px;">操作</td>
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
$.sysop.kit.bindEnterKey('#start_time', searchData);
$.sysop.kit.bindEnterKey('#end_time', searchData);

function searchData(page,disR){
	var $box=$('#box_list').show();
	var fn=arguments.callee;
	var param = 'queue_type='+$('#queue_type').val()+'&start_time='+$('#start_time').val()+'&end_time='+$('#end_time').val();
	var req   =  param+'&page='+(page||1)+'&displayRecord='+(disR=disR||20);//默认20
	$.ajax({
        type: "get",
        async: false,
        url: '/admin/sendLogsList.do',
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
	                  <td><div>'+this.queue_id+'</div></td>\
	                  <td><div>'+this.recipient+'</div></td>\
	                  <td><div>'+this.cc+'</div></td>\
	                  <td><div>'+sendLogType(this.queue_type)+'</div></td>\
	                  <td><div>'+this.queue_index+'</div></td>\
	                  <td><div>'+this.subject+'</div></td>\
	                  <td><div  style="">'+this.result+'</div></td>\
	                  <td><div>'+unixTimeStamp(this.create_time)+'</div></td>\
	                  <td><div><a href="/admin/sendLogsExport.do?id=' + this.id+'&queue_type='+this.queue_type+'">下载</a></div></td>\
	          </tr>');
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
function sendLogType(type){
	if(type==101){
		return "Email";
	}
	if(type==102){
		return "YY";
	}
	if(type==103){
		return "YY群";
	}
	if(type==104){
		return "短信";
	}
}
//searchData();

function unixTimeStamp(timestamp) {
    d = new Date(timestamp);
    var jstimestamp = (d.getFullYear())+"-"+(d.getMonth()+1)+"-"+(d.getDate())+" "+(d.getHours())+":"+(d.getMinutes())+":"+(d.getSeconds());
    return jstimestamp;
}

function download(id,queue_type){
	window.location.href = "/admin/sendLogsExport.do?id=" + id+"&queue_type="+queue_type;
}
</script>
</body>
</html>