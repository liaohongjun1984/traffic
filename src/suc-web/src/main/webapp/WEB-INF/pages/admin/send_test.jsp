<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>测试通道</span></h2>
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
	                        	<th><em class="em">*</em>通道类型：</th>
	                        	<td>
									<select id="queue_type" name="queue_type" class="validate[required]" >
										<option value="101">Email</option>
										<option value="104">短信</option>
									</select>
	                            </td>
	                        </tr>	                		
	                        <tr>
	                        	<th><em class="em">*</em>收件人：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="recipient" name="recipient" placeholder="多个收件人请以逗号隔开"/>
	                            </td>
	                        </tr>
	                        <tr>
	                        	<th><em class="em">*</em>抄送人：</th>
	                        	<td>
	                            	<input type="text" id="cc" name="cc" placeholder="邮件类型有效"/>
	                            </td>
	                        </tr>                 		
	                        <tr>
	                        	<th><em class="em">*</em>标题：</th>
	                        	<td>
	                            	<input type="text" class="validate[required]" id="subject" name="subject"/>
	                            </td>
	                        </tr>             		
	                        <tr>
	                        	<th><em class="em">*</em>内容：</th>
	                        	<td>
	                            	<textarea  id="message" name="message"></textarea>
	                            </td>
	                        </tr>             		
	                        
	                    </tbody>
	                </table>
                <div class="nav">
                   <input type="submit" class="button" id="add_save" value="测试" />
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
function add(){
	if($.validationEngine.submitValidation("#f_1") == true)return;
	var req=$('#f_1').serialize(); 
	var url = '/admin/sendTest.do';
	$.getJSON(url,req,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		$.sysop.popup.autoTip('已经发送.',function(){
		});
	});			
}
</script>
</body>
</html>