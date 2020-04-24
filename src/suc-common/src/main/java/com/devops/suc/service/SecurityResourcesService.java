package com.devops.suc.service;

public interface SecurityResourcesService {

	/**
	 * 初始化整个权限树
	 * @throws Exception 
	 */
	public void initSecurityResouces(int appId) throws Exception;
}
