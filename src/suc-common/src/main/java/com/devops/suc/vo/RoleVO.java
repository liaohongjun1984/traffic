package com.devops.suc.vo;

import com.devops.suc.model.Role;

public class RoleVO extends Role{
	/**
	 * 
	 * 用户名称
	 */
	private String name;
	
	private String cn_name;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCn_name() {
		return cn_name;
	}

	public void setCn_name(String cn_name) {
		this.cn_name = cn_name;
	}

	
	
}
