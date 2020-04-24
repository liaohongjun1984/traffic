package com.devops.suc.vo;

import com.devops.suc.model.App;

public class UserAppVO extends App{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4328244450178839700L;
	
	private String user_name;

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
	public App toApp(){
		App app = new App();
		app.setApp_group_id(this.getApp_group_id());
		app.setApp_id(this.getApp_id());
		app.setApp_key(this.getApp_key());
		app.setCn_name(this.getCn_name());
		app.setDescript(this.getDescript());
		app.setLast_modify(this.getLast_modify());
		app.setName(this.getName());
		app.setOperator(this.getOperator());
		app.setSequence(this.getSequence());
		app.setStatus(this.getStatus());
		app.setUrl(this.getUrl());
		return app;
	}
	

}
