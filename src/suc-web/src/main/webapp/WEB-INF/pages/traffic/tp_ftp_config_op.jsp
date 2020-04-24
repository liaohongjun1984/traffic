<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>FTP服务器设置</span></h2>
			<div class="mainContent" >
				<!-- 系统分组管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>FTP服务器设置</h4>
					</div>
				<div class="cont" >
					<form id="f_1">
					<input type="hidden" name="id" value="0" /> 
	                <table id="f_tb" class="form">
	                	<tbody>
	                        <tr>
	                        	<th><em class="em">*</em>名称：</th>
	                        	<td>
	                        		<input type="text" class="validate[required]" id="ftp_mark" name="ftp_mark" placeholder="请输入名称"/>
	                            </td>
	                        </tr>	   
	                        <tr>
	                        	<th><em class="em">*</em>服务器地址：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="ftp_host" name="ftp_host" placeholder="请输入服务器地址"/>
	                            </td>
	                        </tr>	                    		
	                        <tr>
	                        	<th><em class="em">*</em>服务器端口：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="ftp_port" name="ftp_port" placeholder="请输入服务器端口"/>
	                            </td>
	                        </tr>	 	                		
	                        <tr>
	                        	<th><em class="em">*</em>服务器帐号：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="ftp_user" name="ftp_user" placeholder="请输入服务器帐号"/>
	                            </td>
	                        </tr>            		
	                        <tr>
	                        	<th><em class="em">*</em>服务器密码：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="ftp_pwd" name="ftp_pwd" placeholder="请输入服务器密码"/>
	                            </td>
	                        </tr>  
	                        <tr>
	                        	<th><em class="em">*</em>服务器路径：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="ftp_dir" name="ftp_dir" placeholder="请输入服务器路径"/>
	                            </td>
	                        </tr>  	                                           
	                    </tbody>
	                </table>
                <div class="nav">
                   <input type="button" onclick="history.back()" value="« 返回" /> |
                   <input type="button" class="button" id="add_save" value="保存" />
                </div>
                </form>

				<!-- 角色管理 end -->
			</div>
		</div>
		<!-- right end -->
	</div>
	<!-- mani end -->
	<div class="footer clearfix"></div>
</div>
<script>
$('#f_1').validationEngine({validationEventTriggers:"focusout",promptPosition : "topRight", scroll: false});
$('#add_save').click(add);
function add(){
	if($.validationEngine.submitValidation("#f_1") == true)return;
	var req=$('#f_1').serialize(); 
	var url = '/traffic/tpFtpConfig/tpFtpConfigSave.do';
	$.getJSON(url,req,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		$.sysop.popup.autoTip('维护['+$('#ftp_mark').val()+']信息成功.',function(){
			window.location.href="/traffic/tpFtpConfig/tpFtpConfigList.jspx";
		});
	});			
}

var id = $.sysop.kit.getUrlValue('id');
function pre_data(){
	if(!id) return;
	$.getJSON('/traffic/tpFtpConfig/tpFtpConfigGet.do',"id="+id,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		var data = json.object;
		$.sysop.kit.initFormByJSON('#f_1',data,true);
	});	
}


$(document).ready(function(){
	pre_data();
});
</script>
</body>
</html>