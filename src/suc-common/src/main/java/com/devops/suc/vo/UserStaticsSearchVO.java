package com.devops.suc.vo;

public class UserStaticsSearchVO {
	public static final int WEEK=1;
	public static final int MONTH=2;
	public static final int DAY=3;
	public static final int PERIOD=4;
	private String province;
	private String city;
	private int searchType;
	private String startTime;
	private String endTime;
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public int getSearchType() {
		return searchType;
	}
	public void setSearchType(int searchType) {
		this.searchType = searchType;
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
