/**
 * @author: code@xiepeiyang.com
 * @date: 2016年3月26日-下午5:51:46
 */
package com.devops.suc.vo;

import com.idhoo.dhutil.vo.BaseSearchVO;

public class TpCheckedSearchVO extends BaseSearchVO{
	private int id;
	private int user_id;
	private int road_id;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getRoad_id() {
		return road_id;
	}
	public void setRoad_id(int road_id) {
		this.road_id = road_id;
	}
	
}
