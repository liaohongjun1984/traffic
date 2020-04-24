<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="/admin/images/favicon.ico" type="image/x-icon" />
<title>登录</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/admin/css/reset.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/admin/css/base.css"/>
<script src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/js/jquery.sysop.js" type="text/javascript"></script>
<script>
$(function(){
	$.sysop.kit.browserCheck();//浏览器检测
/**
	$('#form_login').submit(function(){//密码检测
		var s=$('input[name="password"]').val(),zh=$('input[name="username"]').val();
		if(!$.sysop.validation.myCheck.password(s,zh)) return false;
	});
	**/
	localStorage.loginStatus='true';//标记登录状态（获取菜单数据之用）

/*	alert('start ajax');
			
	var param = "{\"guid\":\"27d5128b-5296-4f6f-b802-b154dd53648f\",\"found_proc\":[\"./voice_maixu_d";
	for(var i=0; i<2000; ++i){
	//	param +="_" + i;
	}
	param += "\"]}";	
				
	$.ajax( {
		url : "/rest/procCommonFoundAutoReg.action",
		data : "param="+param, // 参数
		type : "post",
		cache : false,
		dataType : "text",
		error : function(x, er) {
				alert(er);
		},
		success : function(msg) {
			alert(msg);
		}
		}); */
});
</script>
</head>
<body class="login-body">
<div class="top">
	<div class="wrap">
        
    </div>
</div>
<div class="main">
	<div class="header">
    	<div class="logo">
        	<span class="pic"><img src="#" /></span>
            <span class="text">运维管理系统</span>
        </div>
    </div>
    <!-- 
    <div class="post">
    	<p><span class="bold">最新公告：</span>欢迎使用监控报表数据分析系统，本系统暂时处于测试版。欢迎使用监控报表数据分析系统，本系统暂时处于测试版。</p>
    </div>
     -->
	<div class="box-item box-form box-login" id="box-login">
		<div class="tit"><span class="arr"></span>
			<h4>登录运维管理系统 (v4.0)</h4>
		</div>
        <div class="cont">
        	<form action="/admin/login.do" method="post" id="form_login">
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
                <div class="err-tips">test</div>
                <div class="bottom">
                	<input class="button" type="submit" value="登录" />
                </div>
            </form>
        </div>
    </div>
    <!-- <div class="box-tips">
    	<p><b>提示：</b>本系统需要运行在chrome 11及以上谷歌浏览器；如果您是首次登录系统请确认您的浏览器是否是chrome!</p>
    	<p><b>提示：</b>本系统账号/权限开通请找晓康直接联系。</p>
    </div> -->
</div>
</body>
</html>
<style>
.main>.header{height:88px;border-bottom:3px solid #CFE4CF;}
.main > .header .tip{bottom:4px;}
.main > .header .logo{margin-top:22px;position:relative;width:360px;}
.main > .header .logo span.pic{width:60px;height:53px;}
.main > .header .logo span.pic img{height:53px;margin:0;}
.main > .header .logo span.text{left: 54px;}

h2{font-size:14px;color:#BF2200;height:36px;line-height:36px;}
.post{height:26px;line-height:26px;background:#FAFAFA;border-radius:5px;margin:12px 0;}
.post .bold{font-weight:bold;color:#BF2200;padding:12px;}

#box-login{width:500px;margin:44px auto 64px;}/*原：24px auto*/
#box-login .cont .bottom{height:22px;line-height:22px;padding:7px 6px;text-align:right; background:#EEEEEE;border-top:1px solid #ccc;}
#box-login td,#box-login th{padding:12px 6px;}
#box-login .form input{width:202px;}

.box-tips{background:#FAFAFA;line-height:30px;border-radius:5px;padding:12px;}

.err-tips{margin:-20px 0 20px 118px;padding:12px;background:#FFCCCC;border:1px solid #CC0000;border-radius:2px;display:inline-block;}
</style>
<script>
if($('.err-tips').html()=='') $('.err-tips').hide();
else $('.err-tips').show();
</script>