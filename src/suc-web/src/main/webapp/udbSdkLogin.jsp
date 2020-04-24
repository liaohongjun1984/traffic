<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="/resource/admin/img/favicon.ico" type="image/x-icon" />
<title>登录</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/admin/css/reset.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/admin/css/base.css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/admin/css/v1.1.css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/admin/css/login.css"/>
<script src="<%=request.getContextPath()%>/resource/js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/js/jquery.sysop.js" type="text/javascript"></script>
<script>
$(function(){
	//清除缓存数据
	loginout();
    if($.sysop.kit.browserCheck() === false){
        return;
    }
	$.sysop.kit.browserCheck();//浏览器检测
	$('#form_login').submit(function(){//密码检测
		var s=$('input[name="password"]').val(),zh=$('input[name="username"]').val();
		if(!$.sysop.validation.myCheck.password(s,zh)) return false;
	});
});

//清除localStorage的缓存
function loginout(){
	localStorage.removeItem("ips");
	localStorage.removeItem("userNickName");
	localStorage.removeItem("userName");
	localStorage.removeItem("menuData");
	localStorage.removeItem("frontMenuData");
}


function login(){
	var callBack = $.sysop.kit.getUrlValue('callBack');
	var req=$('#form_login').serialize(); 
	$.getJSON('/admin/login.do',req,function(json){
		if(!json.success) {
			alert(json.message);
			return false;
		}
		user = json.object;
		localStorage.loginStatus='true';
		sessionStorage.userName = user.user_name;
		sessionStorage.nickName = user.nick_name;
		if(callBack){
			window.location.href=unescape(callBack);
		}else{
			window.location.href="/admin/welcome.jspx";
		}
	});	
	return false;
}
</script>
</head>
<body class="login-body" onload="loginout()">
<div class="main ">

	 <div class="box-item box-form box-login" id="box-login">
		<div class="tit"><span class="arr"></span>
			<h4>欢迎登录宜章县交警大队非现场执法系统</h4>
		</div>
        <div class="cont">
        	<form action="/admin/udbLogin/preLogin.do" method="post" id="form_login">
            	<table class="form">
                	<tr>
                    	<th>帐号：</th>
                        <td><input type="text" name ="username" maxLength="40" /></td>
                    </tr>
                    <tr>
                    	<th>密码：</th>
                        <td><input type="password" name ="password" maxLength="40" /></td>
                    </tr>
                </table>
               
                <div class="bottom">
                	<input class="button" type="submit" onclick="return login();" value="登录" />
                </div>
            </form>
        </div>
    </div>
    <div class="box-tips" style="display:none" id="errorMsg">
    	<p><b>提示：</b>用户不存在，请找管理员开通账号/权限!</p>
    </div> 
    
</div>

</body>
</html>
<script>
if($('.err-tips').html()=='') $('.err-tips').hide();
else $('.err-tips').show();
</script>