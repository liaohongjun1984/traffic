package com.devops.suc.model;

import java.util.Date;

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
 
public class Role{

	// Fields

	/**操作时间*/

	private Date last_modify;

	/**操作者*/

	private String operator;

	/**应用id*/

	private int app_id;

	/**备注*/

	private String notes;

	/**角色名称*/

	private String role_name;

	/**角色id*/

	private int role_id;

	public Date getLast_modify() {
		return last_modify;
	}

	public void setLast_modify(Date last_modify) {
		this.last_modify = last_modify;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public int getApp_id() {
		return app_id;
	}

	public void setApp_id(int app_id) {
		this.app_id = app_id;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public String getRole_name() {
		return role_name;
	}

	public void setRole_name(String role_name) {
		this.role_name = role_name;
	}

	public int getRole_id() {
		return role_id;
	}

	public void setRole_id(int role_id) {
		this.role_id = role_id;
	}

	

}