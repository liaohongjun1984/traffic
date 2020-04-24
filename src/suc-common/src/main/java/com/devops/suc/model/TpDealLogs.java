package com.devops.suc.model;


public class TpDealLogs{
	
	/** id */
	private int id;
	
	/** 图片存储ID */
	private String file_id;
	
	/** 上传用户名称 */
	private String user_name;
	
	/** 上传用户ID */
	private int user_id;
	
	/** 证件类型 */
	private int certificates_type;
	
	/** 汽车类型 */
	private int car_type_id;
	
	/** 车牌号码 */
	private String car_num;
	
	/** 路口 */
	private int road_id;
	
	/** 违反行为 */
	private int violation_action_id;
	
	/** 状态  0确认匹配 1确认不匹配 2无效 */
	private int file_status;
	
	/** 创建时间 */
	private String create_time;
	
	/** 处理人 */
	private String deal_user_name;
	
	/** 处理时间 */
	private String deal_time;
	
	/** 超速标准值 */
	private String sp_standard;
	
	/** 超速实测值 */
	private String sp_measured;
	
	/** 超速公里米数 */
	private String sp_place_metre;
	
	/** 超速公里数 */
	private String sp_kilometers;
	
	public String getSp_standard() {
		return sp_standard;
	}

	public void setSp_standard(String sp_standard) {
		this.sp_standard = sp_standard;
	}

	public String getSp_measured() {
		return sp_measured;
	}

	public void setSp_measured(String sp_measured) {
		this.sp_measured = sp_measured;
	}

	public String getSp_place_metre() {
		return sp_place_metre;
	}

	public void setSp_place_metre(String sp_place_metre) {
		this.sp_place_metre = sp_place_metre;
	}

	public String getSp_kilometers() {
		return sp_kilometers;
	}

	public void setSp_kilometers(String sp_kilometers) {
		this.sp_kilometers = sp_kilometers;
	}

	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getFile_id() {
		return file_id;
	}

	public void setFile_id(String file_id) {
		this.file_id = file_id;
	}

	public String getUser_name() {
		return user_name;
	}
	
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
	public int getUser_id() {
		return user_id;
	}
	
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	
	public int getCertificates_type() {
		return certificates_type;
	}
	
	public void setCertificates_type(int certificates_type) {
		this.certificates_type = certificates_type;
	}
	
	public int getCar_type_id() {
		return car_type_id;
	}
	
	public void setCar_type_id(int car_type_id) {
		this.car_type_id = car_type_id;
	}
	
	public String getCar_num() {
		return car_num;
	}
	
	public void setCar_num(String car_num) {
		this.car_num = car_num;
	}
	
	public int getRoad_id() {
		return road_id;
	}
	
	public void setRoad_id(int road_id) {
		this.road_id = road_id;
	}
	
	public int getViolation_action_id() {
		return violation_action_id;
	}
	
	public void setViolation_action_id(int violation_action_id) {
		this.violation_action_id = violation_action_id;
	}
	
	public int getFile_status() {
		return file_status;
	}
	
	public void setFile_status(int file_status) {
		this.file_status = file_status;
	}
	
	public String getCreate_time() {
		return create_time;
	}
	
	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}
	
	public String getDeal_user_name() {
		return deal_user_name;
	}
	
	public void setDeal_user_name(String deal_user_name) {
		this.deal_user_name = deal_user_name;
	}
	
	public String getDeal_time() {
		return deal_time;
	}
	
	public void setDeal_time(String deal_time) {
		this.deal_time = deal_time;
	}

}
