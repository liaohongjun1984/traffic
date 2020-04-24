package com.devops.suc.model;

import java.util.Date;

public class SecurityResources implements java.io.Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 6563289588891142488L;
	private int resources_id;
	private int parent_id;
	private String name;
	private String uri;
	private String operator;
	private Date last_modify;
	private double sequence;
	private int app_id;
	private int type;
	
	public int getResources_id() {
		return resources_id;
	}
	public void setResources_id(int resources_id) {
		this.resources_id = resources_id;
	}
	public int getParent_id() {
		return parent_id;
	}
	public void setParent_id(int parent_id) {
		this.parent_id = parent_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUri() {
		return uri;
	}
	public void setUri(String uri) {
		this.uri = uri;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public Date getLast_modify() {
		return last_modify;
	}
	public void setLast_modify(Date last_modify) {
		this.last_modify = last_modify;
	}
	public double getSequence() {
		return sequence;
	}
	public void setSequence(double sequence) {
		this.sequence = sequence;
	}
	public int getApp_id() {
		return app_id;
	}
	public void setApp_id(int app_id) {
		this.app_id = app_id;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
}
