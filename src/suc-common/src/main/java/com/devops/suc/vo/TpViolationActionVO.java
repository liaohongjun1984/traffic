package com.devops.suc.vo;
import java.io.Serializable;


public class TpViolationActionVO  implements Serializable{

	
	/** 自增长ID */
	private int v_id;
	
	/** 行为名称 */
	private String action_name;
	
	/** 路口ID */
	private int road_id;
	
	/** 行为ID */
	private int action_id;
	
	/** 是否选中状态*/
	private int status;
	
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

	public int getRoad_id() {
		return road_id;
	}

	public void setRoad_id(int road_id) {
		this.road_id = road_id;
	}

	public int getAction_id() {
		return action_id;
	}

	public void setAction_id(int action_id) {
		this.action_id = action_id;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

}
