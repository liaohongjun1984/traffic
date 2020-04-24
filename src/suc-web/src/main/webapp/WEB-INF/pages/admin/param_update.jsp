<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_index.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>参数管理</span></h2>
			<div class="mainContent" >
				<!-- 用户管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>参数修改</h4>
					</div>
				<div class="cont" >
					<form id="f_1">
	                <table id="f_tb" class="form">
	                	<tbody>
          	
	                	   <tr>
	                        	<th><em class="em">*</em>参数名称：</th>
	                        	<td>
	                        		<input type="text" class="validate[required]" id="dicKey" name="dicKey"/>
	                            </td>
	                        </tr>	
	                         <tr>
	                        	<th><em class="em">*</em>参数值：</th>
	                        	<td>
	                        		<textarea rows="8" cols="28" class="validate[required]" id="value" name="value">
	                        		
	                        		</textarea>
	                        		  
	                            </td>
	                        </tr>
	                        <tr>
	                        	<th><em class="em">*</em>参数描述：</th>
	                        	<td>
	                        		<input type="text" class="validate[required]" id="name" name="name"/>
	                            </td>
	                        </tr>	
	                	</tbody>
	                </table>
                <div class="nav">
                   <input type="button" onclick="history.back()" value="« 返回" /> |
                   <input type="button" class="button" id="update_param" value="保存" />
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
	
	window.onload=searchData();//自动加载js
	
function searchData(){
		
	var param_id = $.sysop.kit.getUrlValue('param_id');	
	
	$.ajax({
        type: "get",
        async: false,
        url: '/admin/getParamById.do',
        data: {param_id:param_id},
        dataType: "json",
        cache: false,
        success: dealData
    });
	
	function dealData(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		var list=json.object;
//		var $tbody=$box.find('tbody').html('');
		
			$("#dicKey").val(list.dicKey);
			$("#value").val(list.value);
			$("#name").val(list.name);
		
	}
}



$('#f_1').validationEngine({validationEventTriggers:"focusout",promptPosition : "topRight", scroll: false});
$('#update_param').click(update_param);
function update_param(){
	if($.validationEngine.submitValidation("#f_1") == true)return;
	var req=$('#f_1').serialize(); 
	var url = '/admin/updateParam.do';
	$.getJSON(url,req,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		$.sysop.popup.autoTip('修改成功.',function(){
			window.location.href="/admin/param_list.jspx";
		});
	});			
}
</script>
</body>
</html>