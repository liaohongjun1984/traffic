<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>域名权重管理</span></h2>
			<div class="mainContent" >
				<!-- 系统分组管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>域名权重修改</h4>
					</div>
				<div class="cont" >
					<form id="f_1">
					<input type="hidden" id="id" name="id"/>
	                <table id="f_tb" class="form">
	                	<tbody>
	                        <tr>
	                        	<th><em class="em">*</em>主机域名：</th>
	                        	<td>
	                        		<input type="text" class="validate[required]" id="host" name="host"/>
	                            </td>
	                        </tr>	                		
	                        <tr>
	                        	<th><em class="em">*</em>权重：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="weight" name="weight"/>
	                            </td>
	                        </tr>
	                        <tr>
	                        	<th><em class="em">*</em>系统名称：</th>
	                        	<td>
	                        		<select name="app_id" id="app_id" class="validate[required]" >
	                        			<!-- option value="1">可用</option>
	                        			<option value="2">不可用</option-->
	                        		</select>
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
var submitMark = true;
$('#f_1').validationEngine({validationEventTriggers: "focusout", promptPosition: "topRight", scroll: false});
$('#add_save').click(add);
function add() {
	if($.validationEngine.submitValidation("#f_1") == true) return;
	if(isNaN($('#weight').val())) {
		alert('权重请输入数值');
		$('#weight').focus();
		return;
	}
	if(!submitMark) return;
	var req = $('#f_1').serialize();
	var url = '/admin/saveDomainWeights.do';
	$.getJSON(url, req, function(json) {
		if(!json.success) {
			alert(json.message);
			return;
		}
		$.sysop.popup.autoTip('更新系统[' + $('#host').val() + ']成功.', function() {
			window.location.href = "/admin/domain_weights_list.jspx";
		});
	});			
}

function pre_data(){
	var id = $.sysop.kit.getUrlValue('id');
	$.getJSON('/admin/getDomainWeights.do', "id=" + id, function(json) {
		if(!json.success) {
			alert(json.message);
			return;
		}
		var data = json.object;
		$.sysop.kit.initFormByJSON('#f_1', data, true);
	});
}
$(function() {
	$.getJSON('/admin/getAppList.do', function(json) {
		if(!json.success) {
			alert(json.message);
			return;
		}
		var appInfo = $("#app_id");
		appInfo.append("<option value=''>请选择</option>");
		$.each(json.object, function() {
			appInfo.append("<option value='" + this.app_id + "'>" + this.cn_name + "</option>");
		});
		pre_data();
	});
	$('#host, #app_id').bind('change', function() {
		submitMark = false;
		if($('#host').val() == '' || $('#app_id').val() == '') return;
		var req = $('#f_1').serialize();
		$.getJSON('/admin/queryDomainWeights.do', req, function(json) {
			if(!json.success) {
				alert(json.message);
				return;
			}
			var len = json.object.length;
			if(len == 0 || json.object[0].id == $('#id').val()) {
				submitMark = true;
				return;
			}
			$.sysop.popup.autoTip('该系统已经存在主机域名' + $('#host').val() + '，请选择其它系统', function() {
				$('#app_id').val('');
			});
		});
	});
});
</script>
</body>
</html>