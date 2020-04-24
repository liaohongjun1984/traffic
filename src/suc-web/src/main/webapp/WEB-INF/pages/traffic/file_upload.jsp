<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right" id="box_list">
		 	<div class="nav_showhide"></div>
			<h2 id="mainTitle" class="mainTitle"><span>图片上传</span></h2>
			<div class="mainContent">
				<!-- 域名权重管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>图片上传</h4><span class="right count"></span>
					</div>
					<div class="cont">
						<div class="action-bar">
							<input type="file" multiple="multiple" class="button" id="file_upload" value="选择上传文件" />
							<select style="margin-left:50px;width:15%" id="road_id" ><option value="0">请选择图片所属路口</option></select>
							<select style="margin-left:50px;width:15%" id="road_speed" ><option value="0">请选择违法类型</option></select>
							<b style="margin-left:10px" id="road_speed">(1为路口违法，2为超速违法)</b>
							<input type="button" class="button" id="search_isp" onclick="upload()" value="上传文件到服务器" style="margin-left:100px;" />
                    	</div>
						<div class="spsh_con">
								<ul class="checkRep"></ul>
							</div>
						<!-- <div id="progressNumber"></div> -->
					  </div>
					</div>
				<!-- 角色管理 end -->
			</div>
		</div>
		<!-- right end -->
	</div>
</div>
<script>
	//全局保存文件上传对象
	var globalFiles   = [];
	var globalFileNum = 0;
	var fileFilter    = {};
	
	$(document).ready(function(){
		$("#file_upload").change(file_upload_change);
	});
	
	function file_upload_change(){
		
		var files = document.getElementById('file_upload').files;
		
		for(var i =0;i<files.length;i++){
			
			var file = files[i];
			var file_name = file.name;//文件名称
			globalFiles.push(file);
			file.file_num   = (++globalFileNum);
			file.needUpload = true;
			fileFilter["file_num_"+file.file_num] = file;
			
			var reader = new FileReader();
			reader.file_num = file.file_num;
			reader.file_name = file.name;
			
            reader.onload = function(e) {
            	var file_num = e.target.file_num;
            	var file_name = e.target.file_name;
            	console.info(e.target);
                //var $img = $('<img>').attr("src", e.target.result).attr("width","80").attr("height","80");
                
                $li = $('<li style="display:block;margin-right:60px;" file_num="'+file.file_num+'"></li>');
                //$li.append($img);
                $li.append('<span class="progressfile" style="display:block;width:140px;height:auto;font-size:16px;border:1px;height:75px;background:#27549F;color:#FFFFFF">'+file_name+'</span>');
                $li.append('<span id="progressNumber'+file_num+'" style="display:block;width:140px;"></span><br/>');
                $li.append('<a href="javascript:void(0)" class="delBtn" >删除</a>');
                $('.spsh_con ul').append($li);
                
                $li.attr("file_num",file_num);
                
               	$li.find(".delBtn").click(function(){
        			var file_num = $(this).parent().attr("file_num");
        			fileFilter["file_num_"+file_num].needUpload = false;
        			$(this).parent().remove();
        		});
            }
            reader.readAsDataURL(file);
		}
	}
	function upload(){
		var b = 0;
		var a = 0;
		var road_id=$("#road_id").val();
		//var road_name= encodeURI($("#road_id").find("option:selected").text());
		if(road_id==0){
			alert("请选择该图片所属路口！")
		}else{
			for(var i=0;i<globalFiles.length;i++){
				b++;
				if(fileFilter["file_num_"+b].needUpload == true){
					var fd = new FormData();
			          fd.append("fileName", globalFiles[i]);
			          var xhr = new XMLHttpRequest();
			          //监听事件
			          xhr.upload.addEventListener("progress", uploadProgress, false);
			          xhr.addEventListener("load", uploadComplete, false);
			          xhr.addEventListener("error", uploadFailed, false);
			          xhr.addEventListener("abort", uploadCanceled, false);
			          //发送文件和表单自定义参数
			          xhr.open("POST", "/file/uploadFile.do?road_id="+road_id,false);
			          xhr.send(fd);
			 		  
			          console.debug(i);
			          //document.getElementById('progressNumber'+b).innerHTML = 100 + '%';
			          $('#progressNumber'+b).parent().find(".delBtn").remove();
				}
			}
		}
		
		function uploadProgress(evt){
			//此处的evt就是文件上传的所有信息。                
			//evt.lengthComputable,文件是否是空    
			alert("aaa");
				if (evt.lengthComputable) {                    
				//evt.loaded：文件上传的大小   evt.total：文件总的大小                    
				var percentComplete = Math.round((evt.loaded) * 100 / evt.total);   
				alert(percentComplete);
				//加载进度条，同时显示信息                    
				document.getElementById("" + b + "").innerHTML = percentComplete.toString() + '%';                    
				document.getElementById("num" + b + "").value = percentComplete / 100;                    
				}
		}
		
		function uploadComplete(evt){
		    //服务断接收完文件返回的结果
	       //alert(evt.target.responseText);
		   var result = eval("("+evt.target.responseText+")");
		   if(result.code<0){
			   $('#progressNumber'+b).parent().find(".progressfile").css({background: "red"});
			   document.getElementById('progressNumber'+b).innerHTML = "文件已存在，上传失败！";
		   }else{
			   $('#progressNumber'+b).parent().find(".progressfile").css({background: "green"});
			   document.getElementById('progressNumber'+b).innerHTML = 100 + '%';
		   }
		}
		function uploadFailed(evt){
			//alert("上传失败");
		}
		function uploadCanceled(evt){
			//xhr.abort();
		}
		
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
					 $.each(roadList,function(i,item){
			                $option = $('<option value="'+this.cr_id+'">'+(this.road_speed==1?"路口违法":"超速违法")+"-"+this.road_name+'</option>');
			                $('#road_id').append($option);
						});
					 $('#road_speed').append('<option value="">路口违法</option><option value="">超速违法</option>');
				}else{
					alert(json.message);
				}
			}
		});
	}
	
	$(document).ready(function(){
		loadSelect();
	});
	
</script>
</body>
</html>