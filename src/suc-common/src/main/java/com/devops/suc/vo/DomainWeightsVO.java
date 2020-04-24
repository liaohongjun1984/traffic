package com.devops.suc.vo;

import com.devops.suc.model.DomainWeights;

public class DomainWeightsVO extends DomainWeights {
	/**
	 * 系统名称
	 */
	private String cn_name;
	
	private String nick_name;

	public String getCn_name() {
		return cn_name;
	}

	public void setCn_name(String cn_name) {
		this.cn_name = cn_name;
	}

	public String getNick_name() {
		return nick_name;
	}

	public void setNick_name(String nick_name) {
		this.nick_name = nick_name;
	}
	
	
}
