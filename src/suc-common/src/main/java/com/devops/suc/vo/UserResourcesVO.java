package com.devops.suc.vo;

import com.devops.suc.model.SecurityResources;

public class UserResourcesVO extends SecurityResources {
	private String user_name;

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public SecurityResources toRes() {
		SecurityResources res = new SecurityResources();
		res.setApp_id(this.getApp_id());
		res.setLast_modify(this.getLast_modify());
		res.setName(this.getName());
		res.setOperator(this.getOperator());
		res.setParent_id(this.getParent_id());
		res.setResources_id(this.getResources_id());
		res.setType(this.getType());
		res.setSequence(this.getSequence());
		res.setUri(this.getUri());
		return res;
	}
	

}
