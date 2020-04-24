package com.devops.suc.vo;

import com.idhoo.dhutil.vo.ActionBaseVO;

public class DomainWeightsSearchVO extends ActionBaseVO {

	/**主机名*/
	private String host;
	
	/**应用系统id*/
	private int app_id;

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public int getApp_id() {
		return app_id;
	}

	public void setApp_id(int app_id) {
		this.app_id = app_id;
	}
}
