<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="shortcut icon" href="/resource/admin/img/favicon.ico" type="image/x-icon" />
<title>宜章县交警大队非现场执法系统</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/admin/css/validationEngine.jquery.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/admin/css/reset.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/admin/css/base.css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/admin/css/userCenter.css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/admin/css/v1.1.css"/>
<script src="<%=request.getContextPath()%>/resource/js/jquery-1.4.2.min.js"></script>
<script src="<%=request.getContextPath()%>/resource/js/underscore.js"></script>
<script src="<%=request.getContextPath()%>/resource/js/jquery.sysop.js"></script>
<script src="<%=request.getContextPath()%>/resource/js/jquery.menuTree.js"></script>
<script src="<%=request.getContextPath()%>/resource/js/init_base_index.js"></script>
<script src="<%=request.getContextPath()%>/resource/js/jquery.validationEngine-zh_CN.js"></script>
<script src="<%=request.getContextPath()%>/resource/js/jquery.validationEngine.js"></script>
<script src="<%=request.getContextPath()%>/resource/js/check_name.js"></script>
<script src="<%=request.getContextPath()%>/resource/js/lhgcalendar.min.js"></script>
<script src="<%=request.getContextPath()%>/resource/js/app.js"></script>
</head>

<body>
<div class="top" id="top">
  <div class="wrap">
    <div id="logo">
            <a href="index.html"><span class="text">宜章县交警大队非现场执法系统</span></a>
    </div>
    <div class="appLinks">
    	<div class="btn-group">
          <button class="btn btn-mini">快速通道</button>
          <button data-toggle="dropdown" class="btn btn-mini dropdown-toggle"><span class="caret"></span></button>
          <ul class="dropdown-menu" id="top_app_list">
          </ul>
        </div>
    </div>
    <div class="login mr10">
    	欢迎您，
    	<a title="查看个人信息" href="userInfo.html" id="userInfo"></a> ！ [ <a title="修改密码" href="/user/user_update_pwd.jspx">修改密码</a> | <a title="我的工作台" href="/user/index.jspx">我的工作台</a> | <a title="进入后台管理" href="/admin/welcome.jspx" id="haveAdmin" style="display:">后台管理 | </a><a title="退出系统" href="<%=request.getContextPath() %>/admin/logout.do">退出</a> ]
    	<span id="serverIps">当前服务器IP:</span>
    </div>
  </div>
</div>
<div class="container">
<!-- header end -->
