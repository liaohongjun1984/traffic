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
 
public class AdminRoleRelation{

	// Fields

	/**角色id*/

	private Integer roleId;

	/** 管理员id*/

	private Integer adminId;

	// Property accessors

	public Integer getRoleId(){

		return this.roleId;
	}

	public void setRoleId(Integer roleId){

		 this.roleId = roleId;
	}

	public Integer getAdminId(){

		return this.adminId;
	}

	public void setAdminId(Integer adminId){

		 this.adminId = adminId;
	}

}