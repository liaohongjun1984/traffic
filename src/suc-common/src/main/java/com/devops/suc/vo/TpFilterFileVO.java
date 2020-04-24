package com.devops.suc.vo;
import java.io.Serializable;


public class TpFilterFileVO  implements Serializable{

	
	/** id */
	private int id;
	
	/** 文件id */
	private int file_id;
	
	/** 图片下载状态 0 未下载 1 已下载 */
	private int file_down_status;
	
	/** 创建时间 */
	private String creatime;
	
	private String file_name;
	
	private String file_addr;
	
	/** 车牌号 */
	private String car_num;
	
	/** 汽车类型 */
	private String car_type_id;
	
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


	public String getCar_type_id() {
		return car_type_id;
	}

	public void setCar_type_id(String car_type_id) {
		this.car_type_id = car_type_id;
	}
	
}
