package com.devops.suc.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.idhoo.dhutil.dto.Result;

public interface UdbLoginService {

	/**
	 * UDB登录合法性检查
	 * @param response
	 * @param request
	 * @return
	 */
	public Result udbSdkLogin(HttpServletResponse response,HttpServletRequest request);
	/**
	 * 检查运维应用中的权限
	 * @param username
	 * @param response
	 * @param request
	 * @return
	 */
	public Result yymsLoginCheck(String username,HttpServletResponse response,HttpServletRequest request);
}
