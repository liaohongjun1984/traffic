package com.devops.suc.vo;
import java.io.Serializable;


public class TpCarTypeVO  implements Serializable{

	
	/** 自增长ID */
	private int ct_id;
	
	/** 车辆类型名称 */
	private String ct_type_name;
	
	/** 车辆类型ID*/
	private String ct_type_id;
	
	
	public int getCt_id() {
		return ct_id;
	}
	
	public void setCt_id(int ct_id) {
		this.ct_id = ct_id;
	}
	
	public String getCt_type_name() {
		return ct_type_name;
	}
	
	public void setCt_type_name(String ct_type_name) {
		this.ct_type_name = ct_type_name;
	}

	public String getCt_type_id() {
		return ct_type_id;
	}

	public void setCt_type_id(String ct_type_id) {
		this.ct_type_id = ct_type_id;
	}
	
	
}
