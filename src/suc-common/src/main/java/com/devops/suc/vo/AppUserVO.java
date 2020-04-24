package com.devops.suc.vo;

import com.devops.suc.model.User;

public class AppUserVO extends User {
	private int app_id;

	public int getApp_id() {
		return app_id;
	}

	public void setApp_id(int app_id) {
		this.app_id = app_id;
	}
	
	public User toUser(){
		User user = new User();
		user.setAdmin(this.getAdmin());
		user.setDepartment(this.getDepartment());
		user.setEmail(this.getEmail());
		user.setLast_modify(this.getLast_modify());
		user.setMeta_default_data(this.getMeta_default_data());
		user.setMobile_no(this.getMobile_no());
		user.setNick_name(this.getNick_name());
		user.setOperator(this.getOperator());
		user.setPassword(this.getPassword());
		user.setStatus(this.getStatus());
		user.setUser_id(this.getUser_id());
		user.setUser_name(this.getUser_name());
		user.setWork_no(this.getWork_no());
		user.setYy_no(this.getYy_no());
		return user;
	}

}
