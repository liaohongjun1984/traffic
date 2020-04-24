package com.devops.suc.vo;

import java.io.Serializable;

public class TpCarNumTitleVO implements Serializable{

	/** 自增长ID */
	private int crt_id;
	
	/** 车牌前缀名称 */
	private String crt_num_title;
	
	/** 车牌前缀ID*/
	private int crt_num_id;

	public int getCrt_id() {
		return crt_id;
	}

	public void setCrt_id(int crt_id) {
		this.crt_id = crt_id;
	}

	public String getCrt_num_title() {
		return crt_num_title;
	}

	public void setCrt_num_title(String crt_num_title) {
		this.crt_num_title = crt_num_title;
	}

	public int getCrt_num_id() {
		return crt_num_id;
	}

	public void setCrt_num_id(int crt_num_id) {
		this.crt_num_id = crt_num_id;
	}
	
	
}
