package com.devops.suc.model;

public class DomainWeights implements java.io.Serializable {
	
	

	/**
	 * 
	 */
	private static final long serialVersionUID = 7499604222012897497L;

	/** 自增长id */
	private int id;
	
	/** 设置域名 */
	private String host;
	
	/** 权重 */
	private int weight;
	
	/** 应用系统id */
	private int app_id;
	
	/** 备注 */
	private String notes;
	
	/** 更新时间 */
	private String last_modify;
	
	/** 操作者 */
	private String operator;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public int getWeight() {
		return weight;
	}

	public void setWeight(int weight) {
		this.weight = weight;
	}

	public int getApp_id() {
		return app_id;
	}

	public void setApp_id(int app_id) {
		this.app_id = app_id;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public String getLast_modify() {
		return last_modify;
	}

	public void setLast_modify(String last_modify) {
		this.last_modify = last_modify;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

}
