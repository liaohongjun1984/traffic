package com.devops.suc.model;

public class UserGroupRelation {
	
	private int user_id;
	
	private String group_id;
	
	private short charge_admin;

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getGroup_id() {
		return group_id;
	}

	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}

	public short getCharge_admin() {
		return charge_admin;
	}

	public void setCharge_admin(short charge_admin) {
		this.charge_admin = charge_admin;
	}
	
	
}
