/**
 * 
 * @author code@xiepeiyang.com
 * @date 2016.3.26
 * 
 * 已校对表
 */
package com.devops.suc.model;

public class TpChecked{
	/** 自增id **/
	private int id;
	
	/** 对应于tp_upload_temp表的id **/
	private int upload_temp_id;
	
	/** 所属用户名称 **/
	private String user_name;
	
	/** 路口Id **/
	private int road_id;
	
	/** 所属用户Id **/
	private int user_id;
	
	/** 文件名 **/
	private String file_name;
	
	/** 图片存储地址 **/
	private String file_addr;
	
	/** 创建时间 **/
	private String create_time;
	
	/** 图片状态 0已校对 1无效 **/
	private int check_result;
	
	/** 汽车类型名称 **/
	private String car_type_name;
	
	/** 汽车车牌号码 **/
	private String car_num;
	
	/** 违法时间 **/
	private String illegal_time;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUpload_temp_id() {
		return upload_temp_id;
	}

	public void setUpload_temp_id(int upload_temp_id) {
		this.upload_temp_id = upload_temp_id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public int getRoad_id() {
		return road_id;
	}

	public void setRoad_id(int road_id) {
		this.road_id = road_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	public String getFile_addr() {
		return file_addr;
	}

	public void setFile_addr(String file_addr) {
		this.file_addr = file_addr;
	}

	public String getCreate_time() {
		return create_time;
	}

	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}

	public int getCheck_result() {
		return check_result;
	}

	public void setCheck_result(int check_result) {
		this.check_result = check_result;
	}

	public String getCar_type_name() {
		return car_type_name;
	}

	public void setCar_type_name(String car_type_name) {
		this.car_type_name = car_type_name;
	}

	public String getCar_num() {
		return car_num;
	}

	public void setCar_num(String car_num) {
		this.car_num = car_num;
	}

	public String getIllegal_time() {
		return illegal_time;
	}

	public void setIllegal_time(String illegal_time) {
		this.illegal_time = illegal_time;
	}
}
