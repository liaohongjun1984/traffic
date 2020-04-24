<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right" id="box_list">
			<h2 id="mainTitle" class="mainTitle"><span>日志查询</span></h2>
			<div class="mainContent">
				<!-- 用户管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>日志列表</h4><span class="right count"></span>
					</div>
					<div class="cont">
						<div class="action-bar">
				      		<label for="J_sysGroup">系统分组：</label>
				      		<select id="J_sysGroup" name="app_group">
				      			<option value="0">请选择</option>
				      		</select>
				      		<label for="J_sysName">系统名称：</label>
				      		<select id="J_sysName" name="app_id">
				      			<option value="0">请选择</option>
				      		</select>	
				      		<label for="type">日志类型：</label>
				      		<select id="type" name="type">
				      			<option value="0">请选择</option>
				      			<option value="1">系统分组管理</option>
				      			<option value="2">系统管理</option>
				      			<option value="3">用户管理</option>
				      			<option value="4">角色管理</option>
				      			<option value="5">菜单管理</option>
				      			<option value="6">用户登录</option>
				      		</select>				      							
							<span>用户姓名：</span>
							<input type="search" placeholder="用户姓名" name="nick_name" id="nick_name" />
							<br />
							<br />
							<span>关键字：　</span>
							<input type="search" placeholder="关键字" name="key" id="key" />
							<br/><br/><span>操作时间：</span>
							<input type="text" placeholder="起始时间" name="start_time" id="start_time" onclick="$.calendar.Show({format:'yyyy-MM-dd HH:mm'})" readonly />&nbsp;到
							<input type="text" placeholder="结束时间" name="end_time" id="end_time" onclick="$.calendar.Show({format:'yyyy-MM-dd HH:mm'})" readonly />
							<input type="button" class="button" id="search_user" value="搜索" onclick="searchData()" />
                    	</div>
						<table class="cyan tb-actorList">
							<thead>
								<tr>
									<td style="width:60px;">系统名称</td>            
									<td style="width:60px;">用户姓名</td>
									<td style="width:60px;">操作类型</td>
									<td style="width:460px;">日志内容</td>
									<td style="width:100px;">操作结果</td>
									<td style="width:120px;">操作时间</td>
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
	var param = 'app_id='+$('#J_sysName').val()+'&type='+$('#type').val()+'&nick_name='+$('#nick_name').val()+'&key='+$('#key').val()+'&start_time='+$('#start_time').val()+'&end_time='+$('#end_time').val();
	var req   =  param+'&page='+(page||1)+'&displayRecord='+(disR=disR||20);//默认20
	$.ajax({
        type: "get",
        async: false,
        url: '/admin/logSearch.do',
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
	                  <td><div>'+this.app_name+'</div></td>\
	                  <td><div>'+this.nick_name+'</div></td>\
	                  <td><div>'+logType(this.type)+'</div></td>\
	                  <td><div style="width: 400px; word-wrap: break-word; text-align: left;">'+this.content+'</div></td>\
	                  <td><div  style="">'+this.result+'</div></td>\
	                  <td><div>'+unixTimeStamp(this.create_time)+'</div></td>\
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
function logType(type){
	if(type==1){
		return "系统分组管理";
	}
	if(type==2){
		return "系统管理";
	}
	if(type==3){
		return "用户管理";
	}
	if(type==4){
		return "角色管理";
	}
	if(type==5){
		return "菜单管理";
	}
	if(type==6){
		return "用户登录";
	}

	return type;
}
searchData();

function unixTimeStamp(timestamp) {
    d = new Date(timestamp);
    var jstimestamp = (d.getFullYear())+"-"+(d.getMonth()+1)+"-"+(d.getDate())+" "+(d.getHours())+":"+(d.getMinutes())+":"+(d.getSeconds());
    return jstimestamp;
}
//分组
var loadGroupList = function(){
	$.getJSON('/admin/appGroupList.do',function(data){
		if( data.success){
			var list = data.object;
			$.each(list,function(n,item){
				$('#J_sysGroup').append('<option value="'+item.app_group_id+'">'+item.name+'</option>');
			})
		} else {
			alert(data.message);
		}
	});
};
//选择系统
var loadAppinfo = function(id){
	if(id == 0 || id == '') {
		$('#J_sysName').html('<option value="0">请选择</option>');
		return;
	}
	$.getJSON('/admin/getAppList.do?app_group_id='+id+'&status=1',function(data){
		if( data.success){
			var list = data.object;
			$('#J_sysName').html('<option value="0">请选择</option>');
			$.each(list,function(n,item){
				$('#J_sysName').append('<option value="'+item.app_id+'">'+item.cn_name+'</option>');
			})
		} else {
			alert(data.message);
		}
	});
}
$(document).ready(function(){
	//加载分组
	loadGroupList();
	//加载系统列表
	$('#J_sysGroup').change(function(){
		loadAppinfo($(this).val());
	})
});
</script>
</body>
</html>