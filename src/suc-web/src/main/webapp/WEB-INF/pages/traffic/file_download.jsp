<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resource/js/url_show.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/admin/css/url_show.css"/>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right" id="box_list">
		 	<div class="nav_showhide"></div>
			<h2 id="mainTitle" class="mainTitle"><span>图片下载</span></h2>
			<div class="mainContent">
				<!-- 域名权重管理 start -->
				<div class="box-item">
					<div class="tit"> 
						<span class="arr"></span>
						<h4>图片下载</h4>
						<span id="totalAllNum"></span>
						<span class="right count"></span>
					</div>
					<div class="cont">
						<div class="action-bar">
							<select class="file_down_status">  
							  <option value ="0">未下载</option>
							  <option value ="1">已下载</option>
							</select>
							<select style="margin-left:50px;" id="road_id"><option value="0">请选择图片所属路口</option></select>
							<input type="text" placeholder="开始时间" name="keyword" id="inp12" id="beginTime" class="beginTime" onclick="$.calendar.Show({format:'yyyy-MM-dd'})" />&nbsp;
							<input type="text" placeholder="结束时间" name="keyword" id="inp12" id="endTime" class="endTime" onclick="$.calendar.Show({format:'yyyy-MM-dd'})" />&nbsp;
							<input type="button" class="button" id="search_user" value="搜索" onclick="loadPicList()" />
						</div>
					<div>
						<input type="checkbox" id="Like1" value="0" name="myLike_qx">
						<label for="Like1">全选</label>
						<input type="button" class="button allDownload"   value="下载"/>
						<input type="button" class="button downloaded"    value="确认已下载"/>
						<input type="button" class="button allOfDownload" value="全部下载"/>
						<input type="button" class="button" value="导出EXCEL" onclick="exportExcel();"/>
					</div>
					<br>
						<div class="spsh_con">
								<ul></ul>
							</div>
					  </div>
					</div>
				<!-- 角色管理 end -->
			</div>
		</div>
		<!-- right end -->
	</div>
</div>
<script>

$(function(){
	loadSelect();
	//刷新树
	loadPicList();
	//全选
	$(":input[name='myLike_qx']").click(function(){
		if($(this).attr("checked") == true){
			$("input[type=checkbox][data-group='toggle']").attr("checked", true);
		}else{
			$("input[type=checkbox][data-group='toggle']").attr("checked", false);
		};
	});
});

//加载图片列表
function loadPicList() {
	var param = {};
	param.file_down_status = $(".file_down_status").val();
	param.road_id = $("#road_id").val();
	param.beginTime = $(".beginTime").val();
	param.endTime = $(".endTime").val();
	param.displayRecord = 500;
	$.ajax({
		type: 'POST',
		url: '/traffic/tpFilterFile/tpFilterFileList.do',
		data: param,
		dataType: 'json',
		cache: false,
		async: true,
		success: function(json) {
			if(json.success) {
				$('.spsh_con ul').children().filter('li').remove();
				var ad = json.object.lists;
				 $.each(ad,function(i,item){
	                $li = $('<li file_id="'+this.id+'" style="width:100%;height:25px;"><span style="font-size:14px;font-weight:bold;float:left;width:50%;text-align:left">'+this.file_name+'</span></li>');
					$checkBox = $('<input type="checkbox" data-group="toggle" id="'+this.file_id+'" style="float:left;margin-top:5px;" />');
	                $li.append($checkBox);
	                $li.append('<a onclick="download2($(this),'+this.file_id+')" href="javascript:void(0);" style="float:left;margin-top:0px;">下载</a>');
	                $li.append('<a href="'+this.file_addr+'" style="float:left;margin-top:0px;" target="_blank">查看</a>');
	                $li.append('<span style="margin-left:10px;font-size:14px;font-weight:bold;float:left;text-align:left">'+this.creatime+'</span>');
	                $('.spsh_con ul').append($li);
	                
	                $("img").bind("click",function(){
	                	console.info($(this).attr("src"));
	                	url_show($(this).attr("src"));
	                });
				});
				 checkBox();
			}else{
				checkBox();
				alert(json.message);
			}
		}
	});
}

//打包下载
$('.allDownload').click(function(){
	var $selected_orders = $("input[type=checkbox][data-group='toggle']:checked");
    if($selected_orders.length == 0){
    	alert("请选择需要下载的图片");
    	return false;
    }
    var ids = [];
    $selected_orders.each(function(){
    	ids.push($(this).attr("id"));
    });
    downloadFile("/traffic/tpUploadTemp/tpUploadTempDownload.do",{ids:ids.join(",")});
});

//全部打包下载

$('.allOfDownload').click(function(){
	var param = {};
	param.file_down_status = $(".file_down_status").val();
	param.road_id = $("#road_id").val();
	
	$.ajax({
		type: 'POST',
		url:  '/traffic/tpFilterFile/tpFilterFileList.do',
		data: param,
		dataType: 'json',
		cache: false,
		async: true,
		success: function(json) {
			if(json.success) {			
				var ids = [];
				var obj=json.object.lists;
			  	$(obj).each(function() {
					ids.push(this.file_id);
		  		});	 		  
		    	downloadFile("/traffic/tpUploadTemp/tpUploadTempDownloadAll.do",{ids:ids.join(",")}); 
			}else{
				alert(json.message);
			}
		}
	});  
});

//确认已下载
$('.downloaded').click(function(){
	var $selected_orders = $("input[type=checkbox][data-group='toggle']:checked");
    if($selected_orders.length == 0){
    	alert("请选择需要确认的图片");
    	return false;
    }
    var ids = "";
    $selected_orders.each(function(){
    	ids += $(this).attr("id") +",";
    });
    $.ajax({
		type: 'POST',
		url: '/traffic/tpDownLoadTemp/tpDownLoaded.do',
		data: {"ids":ids},
		dataType: 'json',
		cache: false,
		async: true,
		success: function(json) {
			if(json.success) {
				loadPicList();
			}else{
				alert(json.message);
			}
		}
	});
});

//单个图片下载
function download2(obj,file_id){
	downloadFile("/traffic/tpUploadTemp/tpUploadTempSimpleDownload.do",{file_id:file_id});
	obj.parent().remove();
}

function downloadFile(url,param){
	param || (param = {});
	var urlParam = [];
	for(var key in param){
		urlParam.push(key+"="+param[key]);
	}
	if(urlParam.length>0){
		if(url.indexOf("?")>=0){
			url+="&"+urlParam.join("&");
		}else{
			url+="?"+urlParam.join("&");
		}
	}
	var form=$("<form>");
	form.attr("style","display:none");
	form.attr("target","");
	form.attr("method","post");
	form.attr("action",url);
	$("body").append(form);
	
	
	form.submit();
	form.remove();
};

function checkBox(){
	$("input[type=checkbox][name='myLike_qx']").attr("checked", false);
	$("input[type=checkbox][data-group='toggle']").attr("checked", false);
}

//加载选择框
function loadSelect() {		
	$.ajax({
		type: 'POST',
		url: '/traffic/tpRoad/listAll.do',
		data: {},
		dataType: 'json',
		cache: false,
		async: true,
		success: function(json) {
			if(json.success) {
				var roadList = json.object.list;
				$("#totalAllNum").html("|未下载的总数为"+json.object.num+"条记录");
				 $.each(roadList,function(i,item){
		               $option = $('<option value="'+this.cr_id+'">'+this.road_name+'('+this.noDownLoadNum+')'+'</option>');
		                $('#road_id').append($option); 
					});
			}else{
				alert(json.message);
			}
		}
	});
}

//计算各路口未下载文件的个数
function countDownLoad(road_id,road_name){
	var param = {};
	param["road_id"] = road_id;
	param["file_down_status"]=0;
	$.ajax({
		type: 'POST',
		url: '/traffic/tpFilterFile/tpFilterFileList.do',
		data: param,
		dataType: 'json',
		cache: false,
		async: true,
		success: function(json) {
			if(json.success) {
				var downloadCount=json.object.count;;//未下载图片数量				
				 $option = $('<option value="'+road_id+'">'+road_name+'('+downloadCount+')'+'</option>');
	             $('#road_id').append($option);	            
			}else{
				alert(json.message);
			}
		}
	});
	
} 
function exportExcel(){
	var road_id = $("#road_id").val();
	var file_down_status = $(".file_down_status").val();
	var beginTime = $(".beginTime").val();
	var endTime = $(".endTime").val();
	var displayRecord = 500;
	var form=$("<form>");
	form.attr("style","display:none");
	form.attr("target","");
	form.attr("method","post"); 
	form.attr("action","/traffic/tpFilterFile/exportExcel.do?road_id="+road_id+"&file_down_status="+file_down_status+"&beginTime="+beginTime+"&endTime="+endTime+"&displayRecord="+displayRecord);
	$("body").append(form);
	
	
	form.submit();
	form.remove();
}

/* //页面加载完成，就进行数据拖取
$(document).ready(function(){
	//alert("已经更新数据");
	$.ajax({
		type: 'POST',
		url: '/traffic/tpFilterFile/tpFilterFileUpdateSome.do',
		success:function(){
			//alert("调用数据更新操作");
		}
	});
});  */

</script>
</body>
</html>