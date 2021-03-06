package com.devops.suc.vo;

import com.idhoo.dhutil.vo.BaseSearchVO;

public class TpViolationActionSearchVO extends BaseSearchVO{

	/** 自增长ID */
	private int v_id;
	
	/** 行为名称 */
	private String action_name;
	
	/** 行为ID*/
	private int action_id;
	
	/** 路口id*/
	private int cr_id;
	
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

	public int getCr_id() {
		return cr_id;
	}

	public void setCr_id(int cr_id) {
		this.cr_id = cr_id;
	}
	
}
