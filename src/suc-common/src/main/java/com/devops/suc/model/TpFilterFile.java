package com.devops.suc.model;


public class TpFilterFile{
	
	/** id */
	private int id;
	
	/** 文件id */
	private int file_id;
	
	/** 图片下载状态 0 未下载 1 已下载 */
	private int file_down_status;
	
	/** 创建时间 */
	private String creatime;
	
	/** 路口id */
	private int road_id;
	
	/** 车牌号 */
	private String car_num;
	
	/** 汽车类型 */
	private String car_type_id;
	
	/** 违法行为 */
	private int violation_action_id;

	/** 超速标准值 */
	private String sp_standard;
	
	/** 超速实测值 */
	private String sp_measured;
	
	/** 超速公里米数 */
	private String sp_place_metre;
	
	/** 超速公里数 */
	private String sp_kilometers;
	
	private int user_id;
	
	public void setUser_id(int user_id){
		this.user_id = user_id;
	}
	
	public int getUser_id(){
		return user_id;
	}
	
	public String getSp_standard() {
		if("".equals(sp_standard)){
			sp_standard = null;
		}
		return sp_standard;
	}

	public void setSp_standard(String sp_standard) {
		this.sp_standard = sp_standard;
	}

	public String getSp_measured() {
		if("".equals(sp_measured)){
			sp_measured = null;
		}
		return sp_measured;
	}

	public void setSp_measured(String sp_measured) {
		this.sp_measured = sp_measured;
	}

	public String getSp_place_metre() {
		if("".equals(sp_place_metre)){
			sp_place_metre = null;
		}
		return sp_place_metre;
	}

	public void setSp_place_metre(String sp_place_metre) {
		this.sp_place_metre = sp_place_metre;
	}

	public String getSp_kilometers() {
		if("".equals(sp_kilometers)){
			sp_kilometers = null;
		}
		return sp_kilometers;
	}

	public void setSp_kilometers(String sp_kilometers) {
		this.sp_kilometers = sp_kilometers;
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
	
	public int getFile_down_status() {
		return file_down_status;
	}
	
	public void setFile_down_status(int file_down_status) {
		this.file_down_status = file_down_status;
	}

	public int getFile_id() {
		return file_id;
	}

	public void setFile_id(int file_id) {
		this.file_id = file_id;
	}

	public String getCreatime() {
		return creatime;
	}

	public void setCreatime(String creatime) {
		this.creatime = creatime;
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
