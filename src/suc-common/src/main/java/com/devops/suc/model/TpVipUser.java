package com.devops.suc.model;

import java.io.Serializable;

public class TpVipUser{
	
	/** id */
	private int id;
	
	/** 姓名 */
	private String user_name;
	
	/** 性别 */
	private int sex;
	
	/** 职务 */
	private String position;
	
	/** 联系方式 */
	private String mobile;
	
	/** 车牌号 */
	private String car_no;
	
	/** 创建人 */
	private String create_user;
	
	/** 创建时间 */
	private String create_time;
	
	/** 修改人 */
	private String modify_user;
	
	/** 修改时间 */
	private String modify_time;
	
	private int    car_type;
	private String expired_time;
	
	
	public int getCar_type() {
		return car_type;
	}

	public void setCar_type(int car_type) {
		this.car_type = car_type;
	}

	public String getExpired_time() {
		return expired_time;
	}

	public void setExpired_time(String expired_time) {
		this.expired_time = expired_time;
	}

	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getUser_name() {
		return user_name;
	}
	
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
	public int getSex() {
		return sex;
	}
	
	public void setSex(int sex) {
		this.sex = sex;
	}
	
	public String getPosition() {
		return position;
	}
	
	public void setPosition(String position) {
		this.position = position;
	}
	
	public String getMobile() {
		return mobile;
	}
	
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	public String getCar_no() {
		return car_no;
	}
	
	public void setCar_no(String car_no) {
		this.car_no = car_no;
	}
	
	public String getCreate_user() {
		return create_user;
	}
	
	public void setCreate_user(String create_user) {
		this.create_user = create_user;
	}
	
	public String getCreate_time() {
		return create_time;
	}
	
	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}
	
	public String getModify_user() {
		return modify_user;
	}
	
	public void setModify_user(String modify_user) {
		this.modify_user = modify_user;
	}
	
	public String getModify_time() {
		return modify_time;
	}
	
	public void setModify_time(String modify_time) {
		this.modify_time = modify_time;
	}
	
}
