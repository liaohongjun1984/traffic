package com.devops.suc.vo;
import java.io.Serializable;


public class RoldActionRelationVO  implements Serializable{

	
	/** 违法行为id */
	private int action_id;
	
	/** 路口id */
	private int road_id;
	
	public int getAction_id() {
		return action_id;
	}
	
	public void setAction_id(int action_id) {
		this.action_id = action_id;
	}

	public int getRoad_id() {
		return road_id;
	}

	public void setRoad_id(int road_id) {
		this.road_id = road_id;
	}
	
}
