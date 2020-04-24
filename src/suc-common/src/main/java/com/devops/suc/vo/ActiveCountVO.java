package com.devops.suc.vo;

public class ActiveCountVO {
	
	//激活数目
	private int activeCount;
	//未激活数目
	private int notActiveCount;
	//开始时间
	private String startTime;
	//结束时间
	private String endTime;
	
	public int getActiveCount() {
		return activeCount;
	}
	public void setActiveCount(int activeCount) {
		this.activeCount = activeCount;
	}
	public int getNotActiveCount() {
		return notActiveCount;
	}
	public void setNotActiveCount(int notActiveCount) {
		this.notActiveCount = notActiveCount;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	
}
