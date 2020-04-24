package com.devops.suc.vo;

import com.devops.suc.model.Menu;

public class UserMenuVO extends Menu{
	private String user_name;
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public Menu toMenu() {
		Menu menu = new Menu();
		menu.setApp_id(this.getApp_id());
		menu.setLast_modify(this.getLast_modify());
		menu.setMenu_id(this.getMenu_id());
		menu.setName(this.getName());
		menu.setOperator(this.getOperator());
		menu.setParent_id(this.getParent_id());
		menu.setSequence(this.getSequence());
		menu.setUrl(this.getUrl());
		menu.setHide(this.getHide());
		return menu;
	}
	
}
