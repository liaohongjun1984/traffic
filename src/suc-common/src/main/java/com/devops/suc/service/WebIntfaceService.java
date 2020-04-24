package com.devops.suc.service;

import com.idhoo.dhutil.dto.Result;

public interface WebIntfaceService {
	/**
	 * 检测app是否合法
	 * @param app_id
	 * @param app_key
	 * @return
	 */
	boolean checkWebApp(String app_id, String app_key);

	Result listOneUser(String app_id,String user_name,String app_key);
	/**
	 * 查询系统全部用户信息
	 * @param app_id
	 * @return
	 */
	Result listAppUsers(String app_id,String app_key);
	/**
	 * 
	 * @param app_id
	 * @param user_name
	 * @return
	 */
	Result listRess(String app_id, String user_name,String app_key);
	/**
	 * 获取用户菜单
	 * @param app_id
	 * @param user_name
	 * @return
	 */
	Result listMenus(String app_id, String user_name,String app_key);
	/**
	 * 获取用户拥有的系统
	 * @param app_id
	 * @param user_name
	 * @return
	 */
	Result listUserApp(String user_name,String app_id,String app_key);
	
	/**
	 * 获取所有系统
	 * @param app_id
	 * @param app_key
	 * @return
	 */
	Result listAllApp(String app_id,String app_key);
	
	/**
	 * 获取系统的不同host
	 * @param app_id
	 * @param app_key
	 * @return
	 */
	Result listDomain(String app_id, String app_key);
	
	/**
	 * 根据app_id获取对应的系统信息
	 * @param app_id
	 * @param app_key
	 * @return
	 */
	Result getApp(String app_id,String app_key);
	/**
	 * 获取用户角色
	 * @param app_id
	 * @param user_name
	 * @param app_key
	 * @return
	 */
	Result listRole(String app_id, String user_name, String app_key);
	
	/**
	 * 获取所有的用户
	 * @param app_id
	 * @param app_key
	 * @return
	 */
	Result listAllUser(String app_id,String app_key);
}
