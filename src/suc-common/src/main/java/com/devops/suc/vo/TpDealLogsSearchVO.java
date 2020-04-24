package com.devops.suc.vo;

import com.idhoo.dhutil.vo.BaseSearchVO;

public class TpDealLogsSearchVO extends BaseSearchVO{

	/** 上传用户id */
	private int user_id;
	
	/** 上传路口名称 */
	private int road_id;
	
	/** 上传用户名称 */
	private String user_name;
	
	/** 车牌号码 */
	private String car_num;
	
	/**图片存储id*/
	private int file_id;
	
	public int getFile_id() {
		return file_id;
	}

	public void setFile_id(int file_id) {
		this.file_id = file_id;
	}

	/** 时间类型  1创建时间  2违法时间*/
	private int timeType;
	
	/** 开始时间 */
	private String beginTime;
	
	/** 结束时间 */
	private String endTime;
	
		
	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getUser_name() {
		return user_name;
	}
	
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getCar_num() {
		return car_num;
	}

	public void setCar_num(String car_num) {
		this.car_num = car_num;
	}

	public int getTimeType() {
		return timeType;
	}

	public void setTimeType(int timeType) {
		this.timeType = timeType;
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

	public int getRoad_id() {
		return road_id;
	}

	public void setRoad_id(int road_id) {
		this.road_id = road_id;
	}
	
}
