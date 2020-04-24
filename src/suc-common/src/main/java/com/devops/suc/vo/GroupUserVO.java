package com.devops.suc.vo;

import com.devops.suc.model.User;

public class GroupUserVO extends User {
	
	private short charge_admin;
	
	private String group_id;

	public short getCharge_admin() {
		return charge_admin;
	}

	public void setCharge_admin(short charge_admin) {
		this.charge_admin = charge_admin;
	}

	public String getGroup_id() {
		return group_id;
	}

	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}
	
	

}
