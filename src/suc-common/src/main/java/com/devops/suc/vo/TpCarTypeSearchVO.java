package com.devops.suc.vo;

import com.idhoo.dhutil.vo.BaseSearchVO;

public class TpCarTypeSearchVO extends BaseSearchVO{

	/** 车辆类型名称 */
	private String ct_type_name;
	
	/** 车辆类型id*/
	private String ct_type_id;
	
	
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
