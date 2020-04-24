package com.devops.suc.vo;

import com.idhoo.dhutil.vo.BaseSearchVO;

public class TpEqualLogSearchVO extends BaseSearchVO{

	/** 姓名 */
	private String user_name;
	
	/** 车牌号 */
	private String car_no;
	
	public String getUser_name() {
		return user_name;
	}
	
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
	public String getCar_no() {
		return car_no;
	}
	
	public void setCar_no(String car_no) {
		this.car_no = car_no;
	}
	
}
