<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>车牌前缀设置</span></h2>
			<div class="mainContent" >
				<!-- 系统分组管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>车牌前缀设置</h4>
					</div>
				<div class="cont" >
					<form id="f_1">
					<input type="hidden" name="crt_id" value="0" /> 
	                <table id="f_tb" class="form">
	                	<tbody>
	                        <tr>
	                        	<th><em class="em">*</em>车牌前缀名称：</th>
	                        	<td>
	                        		<input type="text" class="validate[required]" id="crt_num_title" name="crt_num_title" placeholder="请输入车牌前缀名称"/>
	                            </td>
	                        </tr>    
	                        <tr>
	                        	<th>车牌前缀编码：</th>
	                        	<td>
	                        		<input type="text" id="crt_num_id" name="crt_num_id" placeholder="请输入车牌前缀编码"/>
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
	if($('#crt_num_id').val()==""){
		$('#crt_num_id').attr("value","-1")
	}
	var req=$('#f_1').serialize();
	var url = '/traffic/tpCarNumTitle/tpCarNumTitleSave.do';
	$.getJSON(url,req,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		$.sysop.popup.autoTip('维护['+$('#crt_num_title').val()+']信息成功.',function(){
			window.location.href="/traffic/tpCarNumTitle/tpCarNumTitleList.jspx";
		});
	});			
}

var crt_id = $.sysop.kit.getUrlValue('crt_id');
function pre_data(){
	if(!crt_id) return;
	$.getJSON('/traffic/tpCarNumTitle/tpCarNumTitleGet.do',"crt_id="+crt_id,function(json){
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