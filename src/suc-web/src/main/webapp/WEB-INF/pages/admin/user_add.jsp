<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>用户添加</span></h2>
			<div class="mainContent" >
				<!-- 系统分组管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>用户添加</h4>
					</div>
				<div class="cont" >
					<form id="f_1">
					<input type="hidden" name="user_id" value="0" /> 
	                <table id="f_tb" class="form">
	                	<tbody>
	                        <tr>
	                        	<th><em class="em">*</em>帐号：</th>
	                        	<td>
	                        		<input type="text" class="validate[required]" id="user_name" name="user_name" placeholder="请输入用户账号"/>
	                            </td>
	                        </tr>	                		
	                        <tr>
	                        	<th><em class="em">*</em>姓名：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="nick_name" name="nick_name" placeholder="请输入用户姓名"/>
	                            </td>
	                        </tr> 	                		
	                        <tr>
	                        	<th><em class="em">*</em>警名：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="work_no" name="work_no" placeholder="请输入用户警号"/>
	                            </td>
	                        </tr>	
	                        <tr>
	                        	<th><em class="em">*</em>所属中队：</th>
	                        	<td>
	                        		<select id="department" name="department" class="validate[required]" >
									</select>
	                            </td>
	                        </tr>	                                                      		
	                        <tr>
	                        	<th><em class="em">*</em>手机：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="mobile_no" name="mobile_no" placeholder="请输入用户手机号码"/>
	                            </td>
	                        </tr>             		
	                             		           		
	                           		
	                        <tr>
	                        	<th><em class="em">*</em>Email：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="email" name="email" placeholder="请输入用户邮箱"/>
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
	var url = '/admin/saveUser.do';
	$.getJSON(url,req,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		if($(":input[name='user_id']").val()==0){
			alert(json.message);
		}
		$.sysop.popup.autoTip('更新系统['+$('#user_name').val()+']成功.',function(){
			window.location.href="/admin/user_list.jspx";
		});
	});			
}

var user_name = $.sysop.kit.getUrlValue('user_name');
var user_id = $.sysop.kit.getUrlValue('user_id');
function pre_data(){
		  initDepSel();
	if(!user_name) return;
	      
	$.getJSON('/admin/getUser.do',"user_name="+user_name,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		var data = json.object;
        $('#mainTitle').find('span').text('用户信息修改');
        $('div.tit').find('h4').text('用户信息修改');
        $('#password').parent().parent().remove();
		
		$.sysop.kit.initFormByJSON('#f_1',data,true);
		$("#user_name").attr("readOnly","true");
	});	
}

function initDepSel(){
   var url = '/admin/group/listFirDep.do';
   
	$.getJSON(url,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		$('#department').append("<option value=''>请选择</option>");
		for(var i=0;i<json.object.length;i++){
              var op = json.object[i];
              $('#department').append('<option value="'+op.id+'">'+op.name+'</option>');
		}
	});		
}

$(document).ready(function(){
	pre_data();
});
</script>
</body>
</html>