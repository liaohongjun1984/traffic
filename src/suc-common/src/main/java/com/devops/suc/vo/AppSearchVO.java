package com.devops.suc.vo;

import com.idhoo.dhutil.vo.ActionBaseVO;

public class AppSearchVO extends ActionBaseVO {

	/** 系统英文名称 */
	private String name;

	/** 系统中文名 */
	private String cn_name;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCn_name() {
		return cn_name;
	}

	public void setCn_name(String cn_name) {
		this.cn_name = cn_name;
	}
	
	
}
