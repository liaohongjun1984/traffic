<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>系统分组添加</span></h2>
			<div class="mainContent" >
				<!-- 系统分组管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>系统分组添加</h4>
					</div>
				<div class="cont" >
					<form id="f_1">
					<input type="hidden" name="app_group_id" value="0" />
	                <table id="f_tb" class="form">
	                	<tbody>
	                        <tr>
	                        	<th><em class="em">*</em>系统分组名称：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="name" name="name"/>
	                            </td>
	                        </tr>
	                    </tbody>
	                </table>
                <div class="nav">
                   <input type="button" onclick="history.back()" value="« 返回" /> |
                   <input type="submit" class="button" id="add_save" value="保存" />
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
//搜索绑定enter
$.sysop.kit.bindEnterKey('#add_save',add);

$('#add_save').click(add);
function add(){
	if($.validationEngine.submitValidation("#f_1") == true)return;
	var req=$('#f_1').serialize(); 
	var url = '/admin/appGroupSave.do';
	$.getJSON(url,req,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		$.sysop.popup.autoTip('更新系统分组['+$('#name').val()+']成功.',function(){
			window.location.href="/admin/app_group_list.jspx";
		});
	});			
}

function pre_data(){
	var app_group_id = $.sysop.kit.getUrlValue('app_group_id');
	$.getJSON('/admin/getAppGroup.do',"app_group_id="+app_group_id,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		var data = json.object;
		$.sysop.kit.initFormByJSON('#f_1',data,true);
	});	
}
$(document).ready(function (){
	var app_group_id = $.sysop.kit.getUrlValue('app_group_id');
	if(app_group_id!=''){
		pre_data();
	}
});
</script>
</body>
</html>
