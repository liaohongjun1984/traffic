package com.devops.suc.model;

import java.util.Date;

public class App implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6149691193803385997L;
	/**流水号**/
	private int app_id;
	/**名称**/
	private String name;
	//中文名称
	private String cn_name;
	/**系统连接上来密码**/
	private String app_key;
	/**显示名称**/
	private String descript;
	/**是否可用,1可用，2不可用**/
	private short status;
	/**所属分组ID**/
	private int app_group_id;
	/**访问url**/
	private String url;
	/**排序**/
	private double sequence;
	/**操作者**/
	private String operator;
	/**更新时间**/
	private Date last_modify;
	
	/**报bug url*/
	private String bug_url;
	
	/**提需求url*/
	private String demand_url;
	
	public String getBug_url() {
		return bug_url;
	}
	public void setBug_url(String bugUrl) {
		bug_url = bugUrl;
	}
	public String getDemand_url() {
		return demand_url;
	}
	public void setDemand_url(String demandUrl) {
		demand_url = demandUrl;
	}
	public int getApp_id() {
		return app_id;
	}
	public void setApp_id(int app_id) {
		this.app_id = app_id;
	}
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
	public String getApp_key() {
		return app_key;
	}
	public void setApp_key(String app_key) {
		this.app_key = app_key;
	}
	public String getDescript() {
		return descript;
	}
	public void setDescript(String descript) {
		this.descript = descript;
	}
	public short getStatus() {
		return status;
	}
	public void setStatus(short status) {
		this.status = status;
	}
	public int getApp_group_id() {
		return app_group_id;
	}
	public void setApp_group_id(int app_group_id) {
		this.app_group_id = app_group_id;
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
