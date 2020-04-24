<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>车辆类型设置</span></h2>
			<div class="mainContent" >
				<!-- 系统分组管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>车辆类型设置</h4>
					</div>
				<div class="cont" >
					<form id="f_1">
					<input type="hidden" name="ct_id" value="0" /> 
	                <table id="f_tb" class="form">
	                	<tbody>
	                        <tr>
	                        	<th><em class="em">*</em>类型名称：</th>
	                        	<td>
	                        		<input type="text" class="validate[required]" id="ct_type_name" name="ct_type_name" placeholder="请输入车辆类型名称"/>
	                            </td>
	                        </tr>    
	                        <tr>
	                        	<th><em class="em">*</em>类型编码：</th>
	                        	<td>
	                        		<input type="text" class="validate[required]" id="ct_type_id" name="ct_type_id" placeholder="请输入车辆类型编码"/>
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
	var url = '/traffic/tpCarType/tpCarTypeSave.do';
	$.getJSON(url,req,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		$.sysop.popup.autoTip('维护['+$('#ct_type_name').val()+']信息成功.',function(){
			window.location.href="/traffic/tpCarType/tpCarTypeList.jspx";
		});
	});			
}

var ct_id = $.sysop.kit.getUrlValue('ct_id');
function pre_data(){
	if(!ct_id) return;
	$.getJSON('/traffic/tpCarType/tpCarTypeGet.do',"ct_id="+ct_id,function(json){
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