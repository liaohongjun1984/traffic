<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>违反交通规则行为设置</span></h2>
			<div class="mainContent" >
				<!-- 系统分组管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>违反交通规则行为设置</h4>
					</div>
				<div class="cont" >
					<form id="f_1">
					<input type="hidden" name="v_id" value="0" /> 
	                <table id="f_tb" class="form">
	                	<tbody>
	                        <tr>
	                        	<th><em class="em">*</em>违反交通规则行为名称：</th>
	                        	<td>
	                        		<input type="text" class="validate[required]" id="action_name" name="action_name" placeholder="违反交通规则行为名称"/>
	                            </td>
	                        </tr> 
	                        <tr>
	                        <th><em class="em">*</em>违反交通规则行为代码：</th>
	                        	<td>
	                        		<input type="text" class="validate[required]" id="action_id" name="action_id" placeholder="违反交通规则行为代码"/>
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
	var url = '/traffic/tpViolationAction/tpViolationActionSave.do';
	$.getJSON(url,req,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		$.sysop.popup.autoTip('维护['+$('#action_name').val()+']信息成功.',function(){
			window.location.href="/traffic/tpViolationAction/tpViolationActionList.jspx";
		});
	});			
}

var v_id = $.sysop.kit.getUrlValue('v_id');
function pre_data(){
	if(!v_id) return;
	$.getJSON('/traffic/tpViolationAction/tpViolationActionGet.do',"v_id="+v_id,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		var data = json.object;
		$.sysop.kit.initFormByJSON('#f_1',data,true);
		//$("#road_id option[value='"+road_id+"']").attr("selected", "selected");
	});	
}

//加载选择框
function loadSelect() {
	
	$.ajax({
		type: 'POST',
		url: '/traffic/tpRoad/listAll.do',
		data: {},
		dataType: 'json',
		cache: false,
		async: true,
		success: function(json) {
			if(json.success) {
				var roadList = json.object;
				 $.each(roadList,function(i,item){
		                $option = $('<option value="'+this.cr_id+'">'+this.road_name+'</option>');
		                $('#road_id').append($option);
					});
			}else{
				alert(json.message);
			}
		}
	});
}


$(document).ready(function(){
	pre_data();
	loadSelect();
});
</script>
</body>
</html>