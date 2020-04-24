<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
<link href="/resource/JNMagnifier/css/lanrenzhijia.css" type="text/css"
	rel="stylesheet" />
<script type="text/javascript"
	src="/resource/JNMagnifier/js/cloud-zoom.1.0.2.min.js"></script>
<div class="main clearfix">
	<div class="left" id="sec-left">
		<div class="menuTree" id="menuTree"></div>
	</div>
	<div class="right">
		<h2 id="mainTitle" class="mainTitle">
			<span>图片校对管理</span>
		</h2>
		<div class="mainContent">
			<!-- 编辑编辑权限树 start -->
			<div class="box-item">
				<div class="tit">
					<span class="arr"></span>
					<h4>图片校对管理</h4>
				</div>
				<div class="top">
					<form id="search_form" name="search_form">
						<div id="J_selectZone" class="field none">
							<label for="J_sysName">浏览组织机构:</label> 
							<select id="J_sysGroup" name="">
								<option value="">请选择</option>
							</select>
						</div>
					</form>
				</div>
				<div class="cont-border">
					<form id="f_1">
						<table id="f_tb" class="form mt0" style="margin-top: 0;">
							<tbody>
								<tr>
									<td width="20%">
										<select id="road_id_list_top" style="width: 260px">
													<option value="0">请选择路口</option>
										</select> 

										<div style="width: 260px" id="pic" class="menuTree">
											未校对列表：
											<ul></ul>
										</div> <!-- <div style="width:95%;" id="menuTreeOS" class="menuTreeOs">treeMenu</div> -->
									</td>
									<td width="80%" class="checkGroupMember">
										<div class="box-item">
											<div class="tit" style="height: 95px;">
												<span class="arr"></span> 
												<select id="certificates_type" style="width: 13%">
													<option value="1">公安牌证件</option>
												</select>
												<select id="car_type_id" style="width: 11%">
													<option value="0">请选择汽车类型</option>
												</select> 
												<select id="car_num_title" style="width: 7%">
													<option value="湘L">湘L</option>
												</select> 
												<input type="text" placeholder="请输入车牌号码" id="car_num" style="width: 26%" /> 
												违法时间：<input type="text" id="year" style="width: 9%"> 
												<input type="text" id="time" style="width: 3%">时
												<input type="text" id="minutes" style="width: 3%">分
												<input type="text" id="seconds" style="width: 3%">秒<br>
												<!-- <input type="text" placeholder="违法时间" name="keyword" id="deal_time" class="deal_time" onclick="$.calendar.Show({format:'yyyy-MM-dd HH:mm:ss'})" />&nbsp;<br>-->
												<select id="road_id_list" style="width: 60%">
													<option value="0">请选择路口</option>
												</select> 
												<select id="violation_action_id" style="width: 37%">
													<option value="0">请选择违反的交通规则</option>
												</select>

												<div id="sp_all" style="width:740px;height:28px;">
												标准值：<input type="text" id="sp_standard" style="width: 4%;" />
												实测值：<input type="text" id="sp_measured" style="width: 4%;" />
												公里数：<input type="text" id="sp_kilometers" style="width: 4%;" />
												地点米数：<input type="text" id="sp_place_metre" style="width: 4%;" />
												</div>
												<br /> 
												<input type="button" class="button" id="search_user_commit" value="确认" onclick="picCheck(1)"> 
												<input type="button" class="button" id="search_user_uncommit" value="无效" onclick="picCheck(2)">
												<input type="button" class="button hidden" style="background: red;" id="search_user_update" value="重新校对" > 
												<input type="button" class="button hidden" style="background: red;" id="search_user_out" value="退出重新校对" > 
											</div>
										</div> <br>
										<table>
											<thead>
											</thead>
											<tbody>
												<tr>
													<td width="70%" valign="top">
														<div class="zoom-section">
															<div class="zoom-small-image"></div>
														</div>
													</td>
													<!--preview end-->
													<td width="30%" valign="top" id="downList">
														<div style="width: 220px" id="DownPic" class="menuTree">
															已校对列表：
															<ul></ul>
															<div class="paginationbar" id="paginationbar">
															</div>
															<!--  分页导航-->
															<div class="displayNum" id="displayNum">
															</div>
															<!-- 每页显示数目导航 -->
															<div class="clear"></div> 
																							
														</div>
													</td>
												</tr>
											</tbody>
										</table>
									</td>
								</tr>
							</tbody>
						</table>

					</form>
					<!-- 编辑编辑权限树 end -->
				</div>
			</div>
			<!-- right end -->
		</div>
		<!-- mani end -->
		<div class="footer clearfix"></div>
	</div>

<style type="text/css">
.modal {
	width: 600px;
	display: none;
	position: absolute;
	background-clip: padding-box;
	background-color: #FFFFFF;
	border: 1px solid rgba(0, 0, 0, 0.3);
	border-radius: 6px 6px 6px 6px;
	box-shadow: 0 3px 7px rgba(0, 0, 0, 0.3);
}

.modal .modal-header {
	border-bottom: 1px solid #EEEEEE;
	padding: 9px 15px;
}

.modal .modal-body {
	padding: 15px;
	height: 400px;
	overflow-y: auto;
}

.modal .modal-footer {
	background-color: #F5F5F5;
	border-radius: 0 0 6px 6px;
	border-top: 1px solid #DDDDDD;
	box-shadow: 0 1px 0 #FFFFFF inset;
	margin-top: 10px;
	padding: 14px 15px 15px;
	text-align: right;
}

.btn_close {
	float: right;
	background: none;
	border: none;
	padding: 0;
	text-shadow: 0 1px 0 #FFFFFF;
	font-size: 20px;
	line-height: 18px;
	font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
}

.btn_small {
	line-height: 16px;
	margin-top: 4px;
	margin-right: 10px;
}

.role_tips {
	float: right;
	margin-right: 10px;
}

.role_tips i {
	display: inline-block;
	vertical-align: middle;
	width: 10px;
	height: 10px;
	border: 1px solid #fff;
	background-color: rgba(51, 154, 184, 0.8);
	box-shadow: 0 1px 3px rgba(0, 0, 0, .5);
	border-radius: 1px;
}

.role_tips label {
	vertical-align: middle;
	margin-left: 5px;
}

#pic a:hover {
	font-size: 18px;
	font-weight: bold;
	color: #ff0000;
	text-decoration: underline
}

.menuTree li {
	height: auto;
	line-height: 26px;
	background-color: #BFC4BF;
	margin-top: 3px;
}

* {
	margin: 0;
	padding: 0;
}

a, img {
	border: 0;
}

ul, li {
	list-style-type: none;
}

.visible{
	visibility: visible;
}

.hidden{
	visibility: hidden;
}
</style>
<script type="text/javascript"src="/resource/JNMagnifier/js/focus.js"></script>
<script src="<%=request.getContextPath()%>/resource/js/jquery.menuTree0718.js"></script>
<script>

	//全局变量，防止重复提交
	var flag = true;
	
	$(function(){
		//刷新树
		loadDownPicList();	//加载已经处理的图片列表
		loadSelect();	//加载路口选择框
		loadCarNumTitle();
		loadPicList();	//加载未处理的图片列表
	});

	$(document).ready(function(){ 
		//双击图片返回到未校对列表
		$("button").dblclick(function(){
			  
		});
		
		$('#search_user_update').click(again);

		$('#road_id_list_top').change(function(){
			loadPicList();
			//autoAppendPic();
			//loadDownPicList();
			$('#road_id_list').val($(this).val());
			loadViolationAction($(this).val());
			loadDownPicList();
			if($('#road_id_list_top option:selected').attr('overspeed')==1){
				$('#sp_all').attr('style','visibility:hidden');
			}else if($('#road_id_list_top option:selected').attr('overspeed')==2){
			    $('#sp_all').attr('style','visibility:visible');
			}
		});

		$('#search_user_out').click(function(){
			showFailed("退出重新校对模式");
			$('#search_user_commit').removeClass('hidden');
			$('#search_user_uncommit').removeClass('hidden');
			$('#search_user_update').addClass('hidden');
			$('#search_user_out').addClass('hidden');
			$(".zoom-small-image").empty();
		});




		$('#road_id_list').change(function(){
			//autoAppendPic();
			loadDownPicList();
			loadViolationAction($(this).val());
			if($('#road_id_list option:selected').attr('overspeed')==1){
				$('#sp_all').attr('style','visibility:hidden');
			}else if($('#road_id_list option:selected').attr('overspeed')==2){
			    $('#sp_all').attr('style','visibility:visible');
			}
		});

		
		$('#car_num_title').change(function(){
			$('#car_num').val($(this).val());
		})
		
		
		//获取当前时间
		getTime();
		
		
		
		
	});

	//获取当前时间
	 function getTime(){
		 var d = new Date();
		 var vyear = d.getFullYear();
		 var vmonth = d.getMonth()+1;
		 var vda = d.getDate();
		 if(vmonth<10){
				var vdate = vyear+"-"+0+vmonth+"-"+vda;
			}else{
				var vdate = vyear+"-"+vmonth+"-"+vda;
			}
		 $('#year').val(vdate);
		 $('#time').val(d.getHours());
		 $('#minutes').val(d.getMinutes());
		 $('#seconds').val(d.getSeconds());
		 
	 }


	 //按下确定按钮进行提交校对图片
	$(document).keydown(function(event){
		if(event.keyCode==13){
			if(flag){
				picCheck(1);
			}
		}
	}); 

	 //翻页操作
	 function changePage(flag){
		if(flag==1){
			loadDownPicList(2,2);
		}
		
	 }
 
	//加载已经处理的图片列表
	function loadDownPicList(page,disR){
		var $box=$('#downList').show();
		var fn=arguments.callee; 	
		//param["file_status"] = 1;				
		var req ="file_status="+1+'&page='+(page||1)+'&displayRecord='+(disR=disR||50)+'&road_id='+$("#road_id_list").val();//默认20		
		$.ajax({
			type: 'POST',
			url: '/traffic/tpUploadTemp/tpUploadTempDownList.do',
			data: req,
			dataType: 'json',
			cache: false,
			async: false,
			success: function(json) {
				
				if(json.success) {
					var count=json.object.count,ad = json.object.lists,p=json.object.page,pCount=json.object.pageCount;				
					
					$('#DownPic ul').find("li").remove();
					 $.each(ad,function(i,item){
						 if(this.file_status == 1)s="已校对";
						 else s="无效";
		                $li = $('<li onclick="updateStatus('+'this,'+this.id+')"user_name="'+this.user_name+'" user_id="'+this.user_id+'" file_name="'+this.file_name+'" file_index="'+this.file_index+'" file_addr="'+this.file_addr+'" id="'+this.id+'" road_id="'+this.road_id+'" ><a href="#" ><div><table><tr><td>'+s+'</td><td><span style="font-size:14px;font-weight:bold;">'+this.car_type_name+"   "+this.car_num+"<br>"+this.illegal_time+'</span></td></tr></table></div></a></li>');
		                $('#DownPic ul').append($li);		                
					});							
				}else{
					alert(json.message);
				}
				
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
		});
	}
	//加载未处理的图片列表
	function loadPicList() {
		var param = {};
		param["road_id"] = $("#road_id_list_top").val();
		param["file_status"] = 0;
		param["page"] = 1;
		param["displayRecord"] = 2000;
		$.ajax({
			type: 'POST',
			url: '/traffic/tpUploadTemp/tpUploadTempList.do',
			data: param,
			dataType: 'json',
			cache: false,
			async: true,
			success: function(json) {
				if(json.success) {
					var ad = json.object.lists;
					$('#pic ul').find("li").remove();
					 $.each(ad,function(i,item){
		                $li = $('<li onclick="appendPic(this,'+this.id+')" user_name="'+this.user_name+'" user_id="'+this.user_id+'" file_name="'+this.file_name+'" file_addr="'+this.file_addr+'" id="'+this.id+'" road_id="'+this.road_id+'"><a href="#" ><span style="font-size:14px;font-weight:bold;">'+this.file_name+'</span></a></li>');
		                $('#pic ul').append($li);
					});
					 //有图片才加载
					 if($("#pic ul li").length > 0){
					 	//当选择了“请选择路口”的时候，不自动加载图片
					 	if($('#road_id_list_top').val()!=0){
						 	autoAppendPic();
					 	}
					 }
				}else{
					alert(json.message);
				}
			}
		});
	}

	
	//提交图片校对
		function picCheck(file_status) {
		flag = true;
		
		if(prompt(file_status)){
			return;
		};
		
		var deal_time = $('#year').val()+" "+$('#time').val()+":"+$('#minutes').val()+":"+$('#seconds').val();
		var param = {};
		param.certificates_type = $("#certificates_type").val();
		param.car_type_id = $("#car_type_id").val();
		param.car_type_name = $("#car_type_id option:selected").text();
		param.car_num = $("#car_num").val();
		param.deal_time = deal_time;  //illegal=deal,在后台数据库表中，违法时间写成了处理时间deal_time
		/* param.deal_time = $('#deal_time').val();
		alert($('#deal_time').val()); */
		param.road_id = $("#road_id_list").val();
		param.violation_action_id = $("#violation_action_id").val();
		param.file_status = file_status;
		
		//超速的数据 cgw
		param.sp_standard = $("#sp_standard").val();
		param.sp_measured = $("#sp_measured").val();
		param.sp_kilometers = $("#sp_kilometers").val();
		param.sp_place_metre = $("#sp_place_metre").val();
		
		
		var file_id = "";
		$(".cloud-zoom").each(function(index, element) {
			file_id += $(this).attr('id') +",";
	  	});
		
		param.file_id = file_id;
		

		
		$.ajax({
			type: 'POST',
			url: '/traffic/tpDealLogs/tpDealLogsSave.do',
			data: param,
			dataType: 'json',
			cache: false,
			async: true,
			error: function(){
				showFailed("校对失败！");
			},
			success: function(json) {
				if(json.success) {
					showFailed("操作成功");
					//清空文件id
					$(".zoom-small-image").empty();
					autoAppendPic();
					loadDownPicList();
					$("#time").val("");
					$("#minutes").val("");
					$("#seconds").val("");
					//记忆上一张违反的交通规则
					$("#violation_action_id option[value='"+param.violation_action_id+"']").attr("selected", "selected");

				}else{
					showFailed("操作失败");
				}
			}
		});
	}

	//用户漏填数据时，提示窗口
	function  prompt(file_status){
		if(file_status != 2){
			if($("#car_type_id").val() == 0){
				showFailed("请选择车辆类型");
				return true;
			}
			if($("#car_num").val() == null || $("#car_num").val() == ""){
				showFailed("请填写车牌号");
				return true;
			}
			if($("#car_num").val().length < 6 ||$("#car_num").val().length > 7 ){
				showFailed("请填写正确的车牌号");
				return true;
			}
			
			if($("#road_id_list").val() == 0){
				showFailed("请选择路口");
				return true;
			}
			
			if($("#violation_action_id").val() == 0){
				showFailed("请选择违反行为");
				return true;
			}
			//判断此所选择的是路口（需要填写违反行为）还是路段（需要填写超速数据）
			//"1"路口，"2"为路段
			//alert($("#road_id_list").find("option:selected").attr("overspeed"));
			if($("#road_id_list").find("option:selected").attr("overspeed")=="2")
			{
				/**
				if($("#sp_standard").val() == ""||$("#sp_standard").val() == null){
					showFailed("请填写标准值");
					return true;
				}
				if($("#sp_measured").val() == ""||$("#sp_measured").val() == null){
					showFailed("请填写实测值");
					return true;
				}
				**/
				if($("#sp_kilometers").val() == ""||$("#sp_kilometers").val() == null){
					showFailed("请公里数");
					return true;
				}
				if($("#sp_place_metre").val() == ""||$("#sp_place_metre").val() == null){
					showFailed("请地点米数");
					return true;
				}
			}
			
		}
		
	}
	
	//加载路口选择框
	function loadSelect() {
		
		$.ajax({
			type: 'POST',
			url: '/traffic/tpUploadTemp/selectList.do',
			data: {},
			dataType: 'json',
			cache: false,
			async: false,
			success: function(json) {
				if(json.success) {
					var carList = json.object.carList;
					var roadList = json.object.roadList;
					var tpViolationActionList = json.object.tpViolationActionList;
					 $.each(carList,function(i,item){
		                $option = $('<option value="'+this.ct_id+'">'+this.ct_type_name+'</option>');
		                $('#car_type_id').append($option);
					});
					//汽车类型默认为小型汽车
					$("#car_type_id").find("option[text='小型汽车']").attr("selected",true);
					/* $.each(roadList,function(i,item){
			                $option = $('<option value="'+this.cr_id+'">'+this.road_name+'</option>');
			                $('#road_id').append($option);
						}); */
					$.each(roadList,function(i,item){
		                $option = $('<option value="'+this.cr_id+'" overspeed="'+this.road_speed+'">'+this.road_speed+"-"+this.road_name+'</option>');
		                $('#road_id_list_top').append($option);
					});
					$.each(roadList,function(i,item){
		                $option = $('<option value="'+this.cr_id+'" overspeed="'+this.road_speed+'">'+this.road_speed+"-"+this.road_name+'</option>');
		                $('#road_id_list').append($option);
					});
					/* $.each(roadList,function(i,item){
		                $option = $('<option value="'+this.cr_id+'">'+this.road_name+'</option>');
		                $('#road_id_Down_list').append($option);
					}); */
					/*  $.each(tpViolationActionList,function(i,item){
			                $option = $('<option value="'+this.v_id+'">'+this.action_name+'</option>');
			                $('#violation_action_id').append($option);
						}); */
				}else{
					alert(json.message);
				}
			}
		});
	}
	
	function loadCarNumTitle(){
		$.ajax({
			type:'post',
			url: '/traffic/tpCarNumTitle/tpCarNumTitleList.do',
			data: {displayRecord:400},
			dataType:'json',
			cache:false,
			async: true,
			success:function(json){
				if(json.success){
					var tpCarNumType = json.object.lists;
					$.each(tpCarNumType,function(i,item){
						 $option = $('<option value="'+this.crt_num_title+'">'+this.crt_num_title+'</option>');
						 $('#car_num_title').append($option);
					});
				}else{
					alert(json.message);
				}
			}
		});
	}
	
	//加载属于路口的违法行为
	function loadViolationAction(road_id) {
		$.ajax({
			type: 'POST',
			url: '/traffic/tpViolationAction/listViolationActionByRoadId.do',
			data: {'road_id':road_id},
			dataType: 'json',
			cache: false,
			async: false,
			success: function(json) {
				$("#violation_action_id").empty();
				$option = $('<option value="0">请选择违反的交通规则</option>');
                $('#violation_action_id').append($option);
				if(json.success) {
					var tpViolationActionList = json.object;
					 $.each(tpViolationActionList,function(i,item){
			                $option = $('<option value="'+this.v_id+'">'+this.action_name+'</option>');
			                $('#violation_action_id').append($option);
						});
				}else{
					alert(json.message);
				}
			}
		});
	}
	
	function pic_remove(obj){
		//获取点击移除的图片的id值
		var id = $(obj).parent().parent().find('a').eq(1).attr('id');

		$('#pic li[id = '+id+']').show();
        /*$('#pic li').each(function(){
        	if($(this).attr('id') == id){
        		$(this).show();
        	}
        });
		*/
		$(obj).parent().parent("#wrap").remove();
	} 

	
	//追加到右侧的审核图片列表
	function appendPic(obj,id){
		//obj.remove();
		var $that = $(obj); 
		var temp_id = $that.attr('id');
		var isReturn = false;
		$('.zoom-small-image a').each(function(){
			if($(this).attr('id') == temp_id){
				showFailed("不能重复添加该图片！");
				isReturn = true;
			}
		});
		if(isReturn){
			return;
		}
		//$("#car_num").val(matchCarNum($that.attr("file_name")));
		$("#car_num").val("湘L");
		var car_num_title = "湘L";
		$("#car_num_title option[value='"+car_num_title+"']").attr("selected", "selected");
		var road_id = $that.attr("road_id");
		$("#road_id_list option[value='"+road_id+"']").attr("selected", "selected");
		$("#road_id_list_top option[value='"+road_id+"']").attr("selected", "selected");
		if($('#road_id_list_top option:selected').attr('overspeed')==1){
				$('#sp_all').attr('style','visibility:hidden');
			}else if($('#road_id_list_top option:selected').attr('overspeed')==2){
			    $('#sp_all').attr('style','visibility:visible');
			}
		//路口的违法行为
		loadViolationAction(road_id);
		$fileName = $("span",$(obj)).html();
		$a = $('<a id="'+id+'" href="'+$that.attr("file_addr")+'" class="cloud-zoom" rel="tint:\'#ff0000\',tintOpacity:0.5,smoothMove:5,zoomWidth:480, adjustY:-4, adjustX:10"></a>');
		var $img = $('<img class="zoom-tiny-image" alt = "Thumbnail 2">').attr("src", $that.attr("file_addr")).attr("width","410").attr("height","320");
		$a.append("<span>"+$fileName+"<a style='width: 30px; position: absolute; top: 0; right: 0; z-index:9999;text-align: center;  color:red;' onclick='pic_remove(this)'>移除</a></span>");
		$a.append($img);
        $('.zoom-small-image').append($a);
        $('.cloud-zoom, .cloud-zoom-gallery').CloudZoom();
        $that.hide();
	}
	
	//自动追加第一个li到右侧的审核图片列表
	function autoAppendPic(){
		$('.zoom-small-image').empty();
		var $first;
		if($("#pic ul li").length > 0){
			//获得#pic下第一个显示的li元素
			$("#pic ul li").each(function(){
					if($(this).css('display') == 'list-item'){
						$first = $(this);
						return false;
					}
			});
			if($first != null){
				var id = $first.attr("id");
				var road_id = $first.attr("road_id");
				if(road_id==null){
					road_id=0;
				}
				$("#road_id_list option[value='"+road_id+"']").attr("selected", "selected");
				$("#road_id_list_top option[value='"+road_id+"']").attr("selected", "selected");
				if($('#road_id_list_top option:selected').attr('overspeed')==1){
					$('#sp_all').attr('style','visibility:hidden');
				}else if($('#road_id_list_top option:selected').attr('overspeed')==2){
				    $('#sp_all').attr('style','visibility:visible');
				}
				//路口的违法行为
				loadViolationAction(road_id);
				
				var file_name = $first.attr("file_name");
				var file_addr = $first.attr("file_addr");
				$first.hide();
					//$("#car_num").val(matchCarNum(file_name));
				$("#car_num").val("湘L");
				var car_num_title = "湘L";
				$("#car_num_title option[value='"+car_num_title+"']").attr("selected", "selected");
				$a = $('<a id="'+id+'" href="'+file_addr+'" class="cloud-zoom" rel="tint:\'#ff0000\',tintOpacity:0.5,smoothMove:5,zoomWidth:480, adjustY:-4, adjustX:10"></a>');
				var $img = $('<img class="zoom-tiny-image" alt = "Thumbnail 2">').attr("src", file_addr).attr("width","410").attr("height","320");
				$a.append("<span>"+file_name+"<a style='width: 30px; position: absolute; top: 0; right: 0; z-index:9999;text-align: center;  color:red;' onclick='pic_remove(this)'>移除</a></span>");
				$a.append($img);
		        $('.zoom-small-image').append($a);
		        $('.cloud-zoom, .cloud-zoom-gallery').CloudZoom();
		    }
		}
	}
	
	//匹配车牌号码
	function matchCarNum(carNum){
		if(carNum){
			r = carNum.match(".*?(湘.*?)-");
			if(r){
				return r[1];
			}
		}
		return "";
	}
	
	 function showFailed(msg){
		msg || (msg = "提交失败");
		$.sysop.popup.autoTip(msg);
	};
	
	function updateStatus(obj,id) {

		var $that = $(obj); 
		var file_index = $that.attr('file_index');
		if(file_index==0){
			showFailed("该条数据有错");
			return;
    	}else{
    		byfile_index(file_index,id);
    	}
    	//loadDownPicList($('.list').find('.cur').html());

    	//根据file_index从数据库拿到处理文件记录，修改前端页面
		$.ajax({
			type: 'POST',
			url: '/traffic/tpDealLogs/tpDealLogsRemember.do',
			data: {'file_index':file_index},
			dataType: 'json',
			cache: false,
			async: false,
			error: function(){
				showFailed("操作失败,请刷新页面");
			},
			success: function(json) {
				
				if(json.success) {
					
					$('#search_user_update').removeClass('hidden');
					$('#search_user_out').removeClass('hidden');
					$('#search_user_commit').addClass('hidden');
					$('#search_user_uncommit').addClass('hidden');

					//当进入重新校对时，要让本来在zoom-small-image里的图片回到未校对的列表中
					$('.zoom-small-image').find('#wrap').each(function(){
						$(this).find('a').eq(0).click();
					});
					$(".zoom-small-image").empty();

					$("#road_id_list_top option[value='"+json.object.road_id+"']").attr("selected", "selected");
					$("#road_id_list option[value='"+json.object.road_id+"']").attr("selected", "selected");
					$("#certificates_type option[value='"+json.object.certificates_type+"']").attr("selected", "selected");
					$("#car_num_title option[value='"+json.object.car_num.substr(0,2)+"']").attr("selected", "selected");
					$("#car_type_id option[value='"+json.object.car_type_id+"']").attr("selected", "selected");
					
					loadViolationAction(json.object.road_id);
					if($('#road_id_list_top option:selected').attr('overspeed')==1){
						$('#sp_all').attr('style','visibility:hidden');
					}else if($('#road_id_list_top option:selected').attr('overspeed')==2){
					    $('#sp_all').attr('style','visibility:visible');
					}
					$("#violation_action_id option[value='"+json.object.violation_action_id+"']").attr("selected", "selected");
					$("#car_num").val(json.object.car_num);
					$("#sp_standard").val(json.object.sp_standard);
					$("#sp_measured").val(json.object.sp_measured);
					$("#sp_place_metre").val(json.object.sp_place_metre);
					$("#sp_kilometers").val(json.object.sp_kilometers);


					var date =  json.object.deal_time.substr(0,10);
				    $("#year").val(date);
				    var time =  json.object.deal_time.substr(11,2);
				    $("#time").val(time);
				    var minutes =  json.object.deal_time.substr(14,2);
				    $("#minutes").val(minutes);
				    var seconds =  json.object.deal_time.substr(17,2);
				    $("#seconds").val(seconds);

				    showFailed("进入重新校对模式");


				}else{
					alert(json.message);
				}
			}

		});
    	
	}

	//按file_index遍历
	function byfile_index(file_index,id){

		var param = {};
		param.file_index = file_index;
		
		$.ajax({
			type:'POST',
			url:'/traffic/tpDownLoadTemp/DownPicByIndex.do',
			data:param,
			dataType:'json',
			cache:false,
			async:true,
			success:function(json){
				if (json.success) {
					var lists = json.object;
					$.each(lists,function(i,item){	
					$a = $('<a id="'+this.id+'" file_index="'+this.file_index+'" href="'+this.file_addr+'" class="cloud-zoom" rel="tint:\'#ff0000\',tintOpacity:0.5,smoothMove:5,zoomWidth:480, adjustY:-4, adjustX:10"></a>');
						var $img = $('<img class="zoom-tiny-image" alt = "Thumbnail 2">').attr("src",this.file_addr).attr("width","410").attr("height","320");
						$a.append("<span>"+this.file_name+"<a style='width: 30px; position: absolute; top: 0; right: 0; z-index:9999;text-align: center; color:red;' onclick='pic_remove(this)'>移除</a></span>");
						$a.append($img);
				        $('.zoom-small-image').append($a);
				        $('.cloud-zoom, .cloud-zoom-gallery').CloudZoom();
					});
				}else{
					showFailed("操作失败");
				}
			}

		});

		

	}

	function again(){


		var id = $(".cloud-zoom").eq(0).attr('file_index');
		try{
			$(".cloud-zoom").each(function(index, element) {
				if ($(this).attr("file_index")!=id) {
					showFailed("需要重新校对的图片不在同一条记录")
					throw new Error();
				}
		  	});
		 }catch(e){
		 	return;
		 }

		 

		 
		var deal_time = $('#year').val()+" "+$('#time').val()+":"+$('#minutes').val()+":"+$('#seconds').val();
		var param = {};
		param.certificates_type = $("#certificates_type").val();
		param.car_type_id = $("#car_type_id").val();
		param.car_num = $("#car_num").val();
		param.deal_time = deal_time;
		param.road_id = $("#road_id_list").val();
		param.violation_action_id = $("#violation_action_id").val();
		
		//超速的数据 cgw
		param.sp_standard = $("#sp_standard").val();
		param.sp_measured = $("#sp_measured").val();
		param.sp_kilometers = $("#sp_kilometers").val();
		param.sp_place_metre = $("#sp_place_metre").val();
		param.id = id;
		
		var file_id = "";
		$(".zoom-small-image .cloud-zoom").each(function(index, element) {
			file_id += $(this).attr('id') +",";
	  	});
		
		param.file_id = file_id;

		$.ajax({
			type:'POST',
			url:'/traffic/tpDealLogs/tpDealLogsAgain.do',
			data:param,
			dataType:'json',
			cache:false,
			async:true,
			success:function(json){
				if (json.success) {
					showFailed("数据清空，请重新校对");
					$('#search_user_update').addClass('hidden');
					$('#search_user_out').addClass('hidden');
					$('#search_user_commit').removeClass('hidden');
					$('#search_user_uncommit').removeClass('hidden');
					
				}else{
					showFailed("操作失败，无法重新校对");
				}
			}
		});
	}

	
	
	
</script>
</body>
</html>