package com.devops.suc.vo;

import com.idhoo.dhutil.vo.BaseSearchVO;

public class TpFilterFileSearchVO extends BaseSearchVO{

	/** id */
	private int id;
	
	private String beginTime;
	
	/** 结束时间 */
	private String endTime;
	
	/** 图片下载状态 0 未下载 1 已下载 */
	private int file_down_status;
	
	/** 路口id */
	private int road_id;
	
	/** 车牌号 */
	private String car_num;
	
	/** 汽车类型 */
	private String car_type_id ;
	
	/** 违法行为 */
	private int violation_action_id;
	
	private int user_id;
	
	public void setUser_id(int user_id){
		this.user_id = user_id;
	}
	
	public int getUser_id(){
		return user_id;
	}

	
	public String getCar_num() {
		return car_num;
	}

	public void setCar_num(String car_num) {
		this.car_num = car_num;
	}



	public int getViolation_action_id() {
		return violation_action_id;
	}

	public void setViolation_action_id(int violation_action_id) {
		this.violation_action_id = violation_action_id;
	}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public int getFile_down_status() {
		return file_down_status;
	}
	
	public void setFile_down_status(int file_down_status) {
		this.file_down_status = file_down_status;
	}

	public int getRoad_id() {
		return road_id;
	}

	public void setRoad_id(int road_id) {
		this.road_id = road_id;
	}


	public String getCar_type_id() {
		return car_type_id;
	}

	public void setCar_type_id(String car_type_id) {
		this.car_type_id = car_type_id;
	}
	
}
