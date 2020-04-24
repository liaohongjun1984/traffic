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
							<input type="file"  multiple="multiple"  name="fileselect[]" class="button" id="fileToUpload" onchange="fileSelected();" value="选择上传文件" /> 
							<input type="button" class="button" id="search_isp"  onclick="uploadFile1()"  value="上传文件到服务器" style="margin-left:100px;" />   
					<div id="messages" style="border: 1px red solid">         
					<p> 文件信息:</p>    
					</div>    
                    	</div>
                    	<div id="progressNumber"></div>
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
<script type="text/javascript"> 
	//全局变量 保存需要过滤的文件
	var globalFileNum = 0;
	var fileFilter    = {};

	function fileSelected() {        
		//当选择文件时先清空原有的div中，此方法是加载文件信息与进度条问题关键            
		$("#messages").text("");            
		a = 0;            
		//获取文件集合            
		var file = document.getElementById('fileToUpload').files;            
		//获取文件各数            
		var fileNum = document.getElementById("fileToUpload").files.length;            
		for (var i = 0; i < fileNum; i++) {                
			//读取图片信息                
			showMsg(file[i], i); 
		}        
	}        
//展示信息        
function showMsg(file, i) { 
	//保存过滤文件 
	file.file_num   = (++i);
	file.needUpload = true;
	fileFilter["file_num_"+file.file_num] = file;
	//图片上传的是图片还是其他            
	if (file.type.indexOf("image") == 0) {                
		//如果是创建filereader对象                
		var reader = new FileReader();    
		
		reader.onload = function (e) {                    
		// e.target.result 的返回结果就是本地图片的路径，同时创建进度条和现实信息     
		var $img = $('<img>').attr("src", e.target.result).attr("width","80").attr("height","80");
                
           $li = $('<li file_num="'+file.file_num+'"></li>');
           $li.append($img);
           $li.append('<progress id="num'+i+'" ></progress><span id="'+i+'"></span><br/>');
           $li.append('<a href="javascript:void(0)" class="delBtn" >删除</a>');
           $('.spsh_con ul').append($li);
           
           $li.find(".delBtn").click(function(){
   			//var file_num = $(this).parent().attr("file_num");
			//fileFilter["file_num_"+file_num].needUpload = false;
			file.needUpload = false;
			$(this).parent().remove(); 
   		});
		};                
		reader.readAsDataURL(file);            
	}            
	else {            
		//如果是文件的                
		var msg = "文件名称：" + file.name + "；文件大小：" + file.size + "；文件类型：" + file.type + "<br/><progress id='num" + i + "' ></progress><span id='" + i + "'></span><br/><br/>";                
		$("#messages").append(msg);            
	}        
}        
		//全局变量a将是作为加载进度条的id值；        
		var a = 0;        
		var fileNum;        
		var file;        
		//单文件上传        
		function uploadFile1(a) {            
		fileNum = document.getElementById("fileToUpload").files.length;           
		file = document.getElementById('fileToUpload').files;            
		//单文件上传显示是没有太大的问题，但是多文件上传就得考虑进度条的显示问了，            
		//uploadProgress(evt) 事件是XMLHttpRequest Leve 2中新加的内容，可以直接用来            
		//监听文件上传时文件的详情信息，但是多文件上传总是最后才会触发此事件，并且是            
		//没有什么规律可言，那么就要处理使没上传一个文件就让他必须触发此事件。            
		uploadFile(file[0]);        
		}        
		//多文件上传的独立方法        
		function uploadFile(file) { 
			//var file_num = file.file_num;
			if(file.needUpload == true){
		//创建FormData()对象            
		var fd = new FormData();            
		fd.append("author", "");            
		fd.append("name", "Html 5 File API/FormData");            
		//文件对象 file            
		fd.append("fileToUpload", file);  
		
			//准备使用ajax上传            
			var xhr = new XMLHttpRequest();            
			//进度条            
			xhr.upload.addEventListener("progress", uploadProgress, false);            
			//下载            
			xhr.addEventListener("load", uploadComplete, false);            
			//错误信息            
			xhr.addEventListener("error", uploadFailed, false);            
			//取消，此功能没有做            
			xhr.addEventListener("abort", uploadCanceled, false);            
			//上传            
			xhr.open("POST", "/file/uploadFile.do");            
			//发送            
			xhr.send(fd);  
		}
		}
		       
	//进度条显示        
	function uploadProgress(evt) {        
		//判断a有没有超出范围            
		if (a < fileNum && a != fileNum) {                
		//此处的evt就是文件上传的所有信息。                
		//evt.lengthComputable,文件是否是空                
			if (evt.lengthComputable) {                    
			//evt.loaded：文件上传的大小   evt.total：文件总的大小                    
			var percentComplete = Math.round((evt.loaded) * 100 / evt.total);                    
			//加载进度条，同时显示信息
			if(document.getElementById("" + a + "")){
				document.getElementById("" + a + "").innerHTML = percentComplete.toString() + '%';                    
				document.getElementById("num" + a + "").value = percentComplete / 100;                    
					//如果上传的结果是100时才让加载下一个文件。如果不够100会继续上传原来的文档。                    
					if (percentComplete == 100) {                        
						a++;                        
						//加载下一个文档                        
						uploadFile(file[a]);                    
					}
			}else{
				a++;                        
				//加载下一个文档                        
				uploadFile(file[a]);
			}
			                
			}
		} 
	}
       function uploadComplete(evt) {}
       function uploadFailed(evt) {             
       	alert("上传失败.");         
       }
       function uploadCanceled(evt) {
       	alert("取消.");         
       }     
</script>
</body>
</html>