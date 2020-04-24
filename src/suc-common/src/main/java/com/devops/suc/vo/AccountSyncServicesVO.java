package com.devops.suc.vo;

public class AccountSyncServicesVO {
	private String streamingNo;
	private String userID;
	private Integer userIDType;
	private String productID;
	private String packageID;
	private Integer opType;
	public String getStreamingNo() {
		return streamingNo;
	}
	public void setStreamingNo(String streamingNo) {
		this.streamingNo = streamingNo;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public Integer getUserIDType() {
		return userIDType;
	}
	public void setUserIDType(Integer userIDType) {
		this.userIDType = userIDType;
	}
	public String getProductID() {
		return productID;
	}
	public void setProductID(String productID) {
		this.productID = productID;
	}
	public String getPackageID() {
		return packageID;
	}
	public void setPackageID(String packageID) {
		this.packageID = packageID;
	}
	public Integer getOpType() {
		return opType;
	}
	public void setOpType(Integer opType) {
		this.opType = opType;
	}
}
