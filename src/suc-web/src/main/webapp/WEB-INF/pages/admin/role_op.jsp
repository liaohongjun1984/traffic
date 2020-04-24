<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>角色管理</span></h2>
			<div class="mainContent" >
				<!-- 角色管理 start -->
				<div class="box-item">
					<div class="tit"> 
						<span class="arr"></span>
						<h4>角色添加</h4>
					</div>
				<div class="cont" >
					<form id="f_1">
	                <table id="f_tb" class="form">
	                	<tbody>
	                		<tr>
	                        	<th><em class="em">*</em>业务系统：</th>
	                        	<td>
	                            	<select class="validate[required]" id="app_id" name="app_id">	
									</select>
	                            </td>
	                        </tr>
	                        <tr>
	                        	<th><em class="em">*</em>角色名称：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="role_name" name="role_name"/>
	                            </td>
	                        </tr>
	                         <tr>
	                            <th><em class="em">*</em>备注：</th>
	                            <td>
	                            	<textarea class="validate[required]" id="notes" name="notes"></textarea>
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
//搜索绑定enter
$.sysop.kit.bindEnterKey('#add_save',add);

var id=$.sysop.kit.getUrlValue('id');
var type=$.sysop.kit.getUrlValue('type');
if( type == 'update'){
	$('#app_id').removeClass();
}
$(function (){
	//$("#f_1").validationEngine();
	$('#f_1').validationEngine({validationEventTriggers:"focusout",promptPosition : "topRight", scroll: false});
	$.getJSON('/admin/getAppList.do',function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		var appInfo = $("#app_id");
		appInfo.append("<option value=''>请选择</option>");
		$.each(json.object,function(){
			appInfo.append("<option value='"+this.app_id+"'>"+this.cn_name+"</option>");
		});
		pre_data();
	});	
});

$('#add_save').click(add);
function add(){
	//if(!$("#f_1").validationEngine('validate'))return;
	if( $.validationEngine.submitValidation("#f_1") == true){
	 	return;
	}
	var req=$('#f_1').serialize(); 
	var url = '/admin/addRole.do';
	if(type == 'update'){
		url = '/admin/updateRole.do';
		req = req + '&role_id='+id;
	}
	$.post(url,req,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		$.sysop.popup.autoTip('操作角色['+$('#role_name').val()+']成功.',function(){
			window.location.href="/admin/role_index.jspx";
		});
	});			
}

function pre_data(){
	if(type!='update') return;
	$('.tit h4').html('角色修改');
	$.getJSON('/admin/getRole.do',"role_id="+id,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		var data = json.object;
		$.sysop.kit.initFormByJSON('#f_1',data,true);
	});	
	$('#app_id').attr("disabled",true);
}

</script>
</body>
</html>
