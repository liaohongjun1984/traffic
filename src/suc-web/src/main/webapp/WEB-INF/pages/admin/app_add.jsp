<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>系统添加</span></h2>
			<div class="mainContent" >
				<!-- 系统分组管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>系统添加</h4>
					</div>
				<div class="cont" >
					<form id="f_1">
					<input type="hidden" name="app_id" value="0" />
	                <table id="f_tb" class="form">
	                	<tbody>
	                        <tr>
	                        	<th><em class="em">*</em>所属系统分组：</th>
	                        	<td>
									<select id="app_group_id" name="app_group_id" class="validate[required]" >
									</select>
	                            </td>
	                        </tr>	                		
	                        <tr>
	                        	<th><em class="em">*</em>系统英文名称：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="name" name="name"/>
	                            </td>
	                        </tr>               		
	                        <tr>
	                        	<th><em class="em">*</em>系统中文名称：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="cn_name" name="cn_name"/>
	                            </td>
	                        </tr>             		
	                        <tr>
	                        	<th><em class="em">*</em>app_key：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="app_key" name="app_key"/>
	                            </td>
	                        </tr>             		
	                        <tr>
	                        	<th><em class="em">*</em>系统描述：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="descript" name="descript"/>
	                            </td>
	                        </tr>          		
	                        <tr>
	                        	<th><em class="em">*</em>可用状态：</th>
	                        	<td>
	                            	<select name="status" id="status">
	                            		<option value="1">可用</option>
	                   
	                            		<option value="2">不可用</option>
	                            	</select>
	                            </td>
	                        </tr>           		
	                        <tr>
	                        	<th><em class="em">*</em>URL：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="url" name="url"/>
	                            </td>
	                        </tr>            		
	                        <tr>
	                        	<th><em class="em">*</em>排序权重：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="sequence" name="sequence"/>
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

var submitMark = true;
//搜索绑定enter
$.sysop.kit.bindEnterKey('#add_save',add);
$('#f_1').validationEngine({validationEventTriggers:"focusout",promptPosition : "topRight", scroll: false});
$('#add_save').click(add);
var app_id = $.sysop.kit.getUrlValue('app_id');
function add(){
	if($.validationEngine.submitValidation("#f_1") == true)return;
	if(!submitMark) return;
	var req=$('#f_1').serialize(); 
	var url = '/admin/appSave.do';
	$.getJSON(url,req,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		$.sysop.popup.autoTip('更新系统['+$('#name').val()+']成功.',function(){
			window.location.href="/admin/app_list.jspx";
		});
	});			
}

function pre_data(){
	if(!app_id) return;
	$.getJSON('/admin/getApp.do',"app_id="+app_id,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		var data = json.object;
		$.sysop.kit.initFormByJSON('#f_1',data,true);
	});	
}
$(document).ready(function (){
	$.getJSON('/admin/appGroupList.do',function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		var appInfo = $("#app_group_id");
		appInfo.append("<option value=''>请选择</option>");
		$.each(json.object,function(){
			appInfo.append("<option value='"+this.app_group_id+"'>"+this.name+"</option>");
		});
		pre_data();
	});		

	$('#name').bind('change', function() {
		submitMark = false;
		var name=$('#name').val();
		if(name == '') return;
		$.getJSON('/admin/queryApp.do','name='+name, function(json) {
			if(!json.success) {
				alert(json.message);
				return;
			}
			var len = json.object.length;
			if(len == 0 || json.object[0].app_id == app_id) {
				submitMark = true;
				return;
			}
			$.sysop.popup.autoTip('已经存在该系统英文名：' + $('#name').val() + '，请重新输入', function() {
				$('#name').val('');
			});
		});
	});	

	$('#cn_name').bind('change', function() {
		submitMark = false;
		var cn_name=$('#cn_name').val();
		if(cn_name == '') return;
		$.getJSON('/admin/queryApp.do','cn_name='+cn_name, function(json) {
			if(!json.success) {
				alert(json.message);
				return;
			}
			var len = json.object.length;
			if(len == 0 || json.object[0].app_id == app_id) {
				submitMark = true;
				return;
			}
			$.sysop.popup.autoTip('已经存在该系统中文名：' + $('#cn_name').val() + '，请重新输入', function() {
				$('#cn_name').val('');
			});
		});
	});	
});
</script>
</body>
</html>