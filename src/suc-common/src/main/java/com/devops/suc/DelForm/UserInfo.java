package com.devops.suc.DelForm;

import java.util.List;

public class UserInfo {

	private int userId;//用户ID
	private String userName;//用户名
	private List<RoadInfo> roadInfo;//路口信息
	
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public List<RoadInfo> getRoadInfo() {
		return roadInfo;
	}
	public void setRoadInfo(List<RoadInfo> roadInfo) {
		this.roadInfo = roadInfo;
	}
	
}
