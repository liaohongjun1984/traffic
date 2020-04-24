package com.devops.suc.vo;


public class MenuTreeVO {
	
	private boolean checked = false;
	
	private String name = "";
	
	private String parentId;
	
	private double sequence;
	
	private String url = "";
	
	private String menuId = "";
	
	private String appId = "";

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public double getSequence() {
		return sequence;
	}

	public void setSequence(double sequence) {
		this.sequence = sequence;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}

	public String getAppId() {
		return appId;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}
	
	
}
