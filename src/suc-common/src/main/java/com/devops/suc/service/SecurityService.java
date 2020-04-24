package com.devops.suc.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.devops.suc.model.User;
import com.idhoo.dhutil.dto.Result;

/**
 * 权限资源控制service
 * @author wangxichun
 *
 */
public interface SecurityService {
	
	/**
	 * 根据用户取得admin
	 * @param userName	--登录名
	 * @return			--com.duowan.yy.sysop.suc.model.Admin
	 */
	User getAdmin(String userName);
	
	/**
	 * 登录
	 * @param username	--用户名
	 * @param password	--密码
	 * @param response	--javax.servlet.http.HttpServletResponse
	 * @param request	--javax.servlet.http.HttpServletRequest
	 * @return			--com.duowan.yy.sysop.privilege.constant.ResultCode
	 */
	Result login(String username,String password,HttpServletResponse response,HttpServletRequest request);
}
