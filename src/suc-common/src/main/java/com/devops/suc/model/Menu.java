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
 
public class Menu implements java.io.Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7076809911506216728L;
	private int app_id;
	private int menu_id;
	private int parent_id;
	private String name;
	private String url;
	private double sequence;
	private String operator;
	private Date   last_modify;
	//0为不隐藏 1为隐藏
	private short  hide;
	
	public short getHide() {
		return hide;
	}
	public void setHide(short hide) {
		this.hide = hide;
	}
	public int getApp_id() {
		return app_id;
	}
	public void setApp_id(int app_id) {
		this.app_id = app_id;
	}
	public int getMenu_id() {
		return menu_id;
	}
	public void setMenu_id(int menu_id) {
		this.menu_id = menu_id;
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
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public double getSequence() {
		return sequence;
	}
	public void setSequence(double sequence) {
		this.sequence = sequence;
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
}