<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>重要人物添加</span></h2>
			<div class="mainContent" >
				<!-- 系统分组管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>重要人物添加</h4>
					</div>
				<div class="cont" >
					<form id="f_1">
					<input type="hidden" name="id" value="0" /> 
	                <table id="f_tb" class="form">
	                	<tbody>
	                        <tr>
	                        	<th><em class="em">*</em>姓名：</th>
	                        	<td>
	                        		<input type="text" class="validate[required]" id="user_name" name="user_name" placeholder="请输入姓名"/>
	                            </td>
	                        </tr>	   
	                        <tr>
	                        	<th><em class="em">*</em>车牌号：</th>
	                        	<td>
	                            	<input type="text" class="validate[required,minSize[7],maxSize[8]]" id="car_no" name="car_no" placeholder="请输入车牌号"/>
	                            </td>
	                        </tr>	
	                        <tr>
	                        	<th><em class="em">*</em>车辆类型：</th>
	                        	<td>
	                        		<select id="car_type" name="car_type" class="validate[required]" >
									</select>
	                            </td>
	                        </tr>	 
	                        <tr>
	                        	<th><em class="em">*</em>过期时间：</th>
	                        	<td>
	                        		<input type="text" class="validate[required]" id="expired_time" name="expired_time" placeholder="请输入过期时间" onclick="$.calendar.Show({format:'yyyy-MM-dd HH:mm'})" readonly />
	                            </td>
	                        </tr>		                                                                   		
	                        <tr>
	                        	<th>性别：</th>
	                        	<td>
	                            	<select id="sex" name="sex" >
	                            		<option value="0">选择性别</option>
	                            		<option value="1">男</option>
	                            		<option value="2">女</option>
									</select>
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
	var url = '/traffic/tpVipUser/tpVipUserSave.do';
	$.getJSON(url,req,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		$.sysop.popup.autoTip('维护['+$('#user_name').val()+']信息成功.',function(){
			window.location.href="/traffic/tpVipUser/tpVipUserList.jspx";
		});
	});			
}

var id = $.sysop.kit.getUrlValue('id');
function pre_data(){
	if(!id) return;
	$.getJSON('/traffic/tpVipUser/tpVipUserGet.do',"id="+id,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		var data = json.object;
		$.sysop.kit.initFormByJSON('#f_1',data,true);
	});	
}
function initCarType(){
	   var url = '/traffic/tpCarType/tpCarTypeList.do';
	   
		$.getJSON(url,function(json){
			if(!json.success) {
				alert(json.message);
				return;
			}
			$('#car_type').append("<option value=''>请选择</option>");
			for(var i=0;i<json.object.lists.length;i++){
	              var op = json.object.lists[i];
	              $('#car_type').append('<option value="'+op.ct_id+'">'+op.ct_type_name+'</option>');
			}
		});		
	}

$(document).ready(function(){
	$.ajaxSetup({async: false});
	
	initCarType();
	pre_data();
	
	$.ajaxSetup({async: true});	
});
</script>
</body>
</html>