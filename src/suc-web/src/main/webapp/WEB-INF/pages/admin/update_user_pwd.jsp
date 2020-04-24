<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_index.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>用户管理</span></h2>
			<div class="mainContent" >
				<!-- 用户管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>用户密码修改</h4>
					</div>
				<div class="cont" >
					<form id="f_1">
	                <table id="f_tb" class="form">
	                	<tbody>
	                	
	                	<tr>
	                   
	                        	<td>
	                        		<input type="hidden" class="validate[required]" id="username" name="username"/>
	                            </td>
	                        </tr>	
	                	
	                	   <tr>
	                        	<th><em class="em">*</em>密码：</th>
	                        	<td>
	                        		<input type="text" class="validate[required]" id="old_pwd" name="old_pwd"/>
	                            </td>
	                        </tr>	
	                         <tr>
	                        	<th><em class="em">*</em>新密码：</th>
	                        	<td>
	                        		<input type="text" class="validate[required]" id="new_pwd" name="new_pwd"/>
	                            </td>
	                        </tr>
	                        <tr>
	                        	<th><em class="em">*</em>确认新密码：</th>
	                        	<td>
	                        		<input type="text" class="validate[required]" id="new_pwd1" name="new_pwd1"/>
	                            </td>
	                        </tr>	
	                	</tbody>
	                </table>
                <div class="nav">
                   <input type="button" onclick="history.back()" value="« 返回" /> |
                   <input type="button" class="button" id="update_pwd" value="保存" />
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
$(document).ready(function(){
	var user_name = localStorage.getItem("userName");
	$('#username').val(user_name);
});

$('#f_1').validationEngine({validationEventTriggers:"focusout",promptPosition : "topRight", scroll: false});
$('#update_pwd').click(update_pwd);
function update_pwd(){
	if($.validationEngine.submitValidation("#f_1") == true)return;
	var req=$('#f_1').serialize(); 
	var url = '/admin/updateUserPwd.do';
	$.getJSON(url,req,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		$.sysop.popup.autoTip('重置密码成功.',function(){
			window.location.href="/admin/user_list.jspx";
		});
	});			
}
</script>
</body>
</html>