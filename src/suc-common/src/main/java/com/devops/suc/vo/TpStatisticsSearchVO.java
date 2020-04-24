package com.devops.suc.vo;

import com.idhoo.dhutil.vo.BaseSearchVO;

public class TpStatisticsSearchVO extends BaseSearchVO{

	/** 自增长ID */
	private int cr_id;
	
	/** 开始时间 */
	private String beginTime;
	
	/** 结束时间 */
	private String endTime;
	
	/** 自增长ID */
	private int user_id;
	
	public int getCr_id() {
		return cr_id;
	}
	
	public void setCr_id(int cr_id) {
		this.cr_id = cr_id;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	
}
