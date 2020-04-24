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
 
public class RoleMenuRelation{

	// Fields

	/**权限id*/

	private Integer roleId;

	/**角色id*/

	private String menuId;

	// Property accessors

	public Integer getRoleId(){

		return this.roleId;
	}

	public void setRoleId(Integer roleId){

		 this.roleId = roleId;
	}

	public String getMenuId(){

		return this.menuId;
	}

	public void setMenuId(String menuId){

		 this.menuId = menuId;
	}

}