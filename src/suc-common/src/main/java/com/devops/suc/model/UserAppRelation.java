package com.devops.suc.model;

/**
 * <pre>
 * Title:
 * Description: 
 * </pre>
 * @author wangxc  wangxc@yuchengtech.com
 * @version 1.00.00
 * <pre>
 * 
 * </pre>
 */
 
public class UserAppRelation{

	// Fields

	/**应用id*/

	private String appId;

	/** 管理员id*/

	private Integer adminId;

	// Property accessors

	public String getAppId(){

		return this.appId;
	}

	public void setAppId(String appId){

		 this.appId = appId;
	}

	public Integer getAdminId(){

		return this.adminId;
	}

	public void setAdminId(Integer adminId){

		 this.adminId = adminId;
	}

}