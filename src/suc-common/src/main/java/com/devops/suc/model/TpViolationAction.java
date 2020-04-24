package com.devops.suc.model;

import java.io.Serializable;

public class TpViolationAction{
	
	/** 自增长ID */
	private int v_id;
	
	/** 行为名称 */
	private String action_name;
	
	/** 行为ID*/
	private int action_id;
	
	public int getV_id() {
		return v_id;
	}
	
	public void setV_id(int v_id) {
		this.v_id = v_id;
	}
	
	public String getAction_name() {
		return action_name;
	}
	
	public void setAction_name(String action_name) {
		this.action_name = action_name;
	}

	public int getAction_id() {
		return action_id;
	}

	public void setAction_id(int action_id) {
		this.action_id = action_id;
	}
	
}
