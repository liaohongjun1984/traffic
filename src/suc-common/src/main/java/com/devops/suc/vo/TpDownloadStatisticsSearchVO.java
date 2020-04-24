package com.devops.suc.vo;

import com.idhoo.dhutil.vo.BaseSearchVO;

public class TpDownloadStatisticsSearchVO extends BaseSearchVO{

	/** 操作人name */
	private String user_name;
	
	/** 开始时间 */
	private String beginTime;
	
	/** 结束时间 */
	private String endTime;
	
	public String getUser_name() {
		return user_name;
	}
	
	public void setUser_name(String user_name) {
		this.user_name = user_name;
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
	
}
