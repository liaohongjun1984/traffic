<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_index.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>用户信息修改</span></h2>
			<div class="mainContent" >
				<!-- 系统分组管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>用户信息修改</h4>
					</div>
				<div class="cont" >
					<form id="f_1">
	                <table id="f_tb" class="form">
	                	<tbody>
	                        <tr>
	                        	<th><em class="em">*</em>用户帐号：</th>
	                        	<td>
	                        		<input type="text" class="validate[required]" id="user_name" name="user_name"/>
	                            </td>
	                        </tr>	                		
	                        <tr>
	                        	<th><em class="em">*</em>用户名称：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="nick_name" name="nick_name"/>
	                            </td>
	                        </tr>           		
	                        <tr>
	                        	<th><em class="em">*</em>用户手机号：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="mobile_no" name="mobile_no"/>
	                            </td>
	                        </tr>             		
	                        <tr>
	                        	<th><em class="em">*</em>用户工号：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="work_no" name="work_no"/>
	                            </td>
	                        </tr>          		
	                        <tr>
	                        	<th><em class="em">*</em>所在部门：</th>
	                        	<td>
	                            	<select name="department" id="department">
	                            		<option value="1">B2C</option>
	                            		<option value="2">移动</option>
	                            	</select>
	                            </td>
	                        </tr>           		
	                        <tr>
	                        	<th><em class="em">*</em>rtx号：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="yy_no" name="yy_no"/>
	                            </td>
	                        </tr>            		
	                        <tr>
	                        	<th><em class="em">*</em>Email：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="email" name="email"/>
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
	var url = '/WEB-INF/WEB-INF/pages/include/updateInfo.do';
	$.getJSON(url,req,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		$.sysop.popup.autoTip('更新系统['+$('#user_name').val()+']成功.',function(){
			window.location.href="/admin/user_list.jspx";
		});
	});			
}

function viewInfo(){
	$.ajax({
        type: "get",
        async: false,
        url: '/WEB-INF/WEB-INF/pages/include/getUser.do',
        dataType: "json",
        cache: false,
        success: dealData
    });
	function dealData(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		var data = json.object;
		$.sysop.kit.initFormByJSON('#f_1',data,true);
		$("#user_name").attr("disabled",true);
	}	
}
viewInfo();

//过虑显示联系电话
function filterMobileNo(mobile_no){
	if(mobile_no==null){
		return "&nbsp;"
	}
	if(mobile_no=="null"){
		return "&nbsp;";
	}
	if(mobile_no==0){
		return "&nbsp;";
	}
	if(mobile_no=="0"){
		return "&nbsp;";
	}
	return mobile_no;
}
</script>
</body>
</html>