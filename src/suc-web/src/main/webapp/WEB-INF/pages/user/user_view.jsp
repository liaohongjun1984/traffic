<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_index.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>用户管理</span></h2>
			<div class="mainContent" >
				<!-- 用户管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>用户信息查看</h4>
					</div>
				<div class="cont" >
					<form id="f_1">
	                <table id="f_tb" class="form">
	                	<tbody></tbody>
	                </table>
                <div class="nav">
                   <input type="button" onclick="history.back()" value="« 返回" /> 
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

var user_name=$.sysop.kit.getUrlValue('user_name');

function viewInfo(){
	var req   =  'user_name='+user_name;//默认20
	$.ajax({
        type: "get",
        async: false,
        url: '/common/getUser.do',
        data: req,
        dataType: "json",
        cache: false,
        success: dealData
    });
	function dealData(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		
		var $tbody=$("#f_tb").find('tbody').html('');
		
		var user = json.object;
		
		$tbody.append('<tr>\
            	<th>用户帐号：</th>\
            	<td>'+user.user_name+'</td>\
            </tr>\
            <tr>\
            	<th>真实姓名：</th>\
            	<td>'+user.nick_name+'</td>\
            </tr>\
             <tr>\
                <th>用户状态：</th>\
                <td>'+(user.status==1?"正常":(user.status==2?"冻结":"初始化"))+'</td>\
            </tr>\
             <tr>\
                <th>移动电话：</th>\
                <td>'+filterMobileNo(user.mobile_no)+'</td>\
            </tr>\
             <tr>\
                <th>邮箱地址：</th>\
                <td>'+user.email+'</td>\
            </tr>\
            </tr>');
	}	
}
viewInfo();

//过虑显示联系电话
function filterMobileNo(mobile_no){
	if(mobile_no==null){
		return "&nbsp;"
	}
	if(mobile_no=="null"){
		return "&nbsp;";
	}
	if(mobile_no==0){
		return "&nbsp;";
	}
	if(mobile_no=="0"){
		return "&nbsp;";
	}
	return mobile_no;
}
</script>
</body>
</html>