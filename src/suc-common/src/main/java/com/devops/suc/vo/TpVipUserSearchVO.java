package com.devops.suc.vo;

import com.idhoo.dhutil.vo.BaseSearchVO;

public class TpVipUserSearchVO extends BaseSearchVO{

	/** 姓名 */
	private String user_name;
	
	/** 联系方式 */
	private String mobile;
	
	/** 车牌号 */
	private String car_no;
	
	public String getUser_name() {
		return user_name;
	}
	
	public void setUser_name(String user_name) {
		this.user_name = user_name;
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
	
}
