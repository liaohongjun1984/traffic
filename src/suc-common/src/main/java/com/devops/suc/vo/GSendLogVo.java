package com.devops.suc.vo;

public class GSendLogVo {

	/** 自增长Id */
	private int id;
	
	/** 收发号码 */
	private String mobileNum;
	
	/** 短信类型：1：短信，2：彩信 */
	private int msgStatus;
	
	/** 发送方式：1：上行，2：下行 */
	private int sendMode;
	
	/** 发送状态：1：手机指令上行成功；2：手机指令下行成功 */
	private int sendStatus;
	
	/** 发送时间 */
	private String sendTime;
	
	/** 短信内容 */
	private String msg;
	
	/** 始发短信标识位:0:不是始发上行；1：是始发上行 */
	private int startFlag;

	public int getStartFlag() {
		return startFlag;
	}

	public void setStartFlag(int startFlag) {
		this.startFlag = startFlag;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getMobileNum() {
		return mobileNum;
	}

	public void setMobileNum(String mobileNum) {
		this.mobileNum = mobileNum;
	}

	public int getMsgStatus() {
		return msgStatus;
	}

	public void setMsgStatus(int msgStatus) {
		this.msgStatus = msgStatus;
	}

	public int getSendMode() {
		return sendMode;
	}

	public void setSendMode(int sendMode) {
		this.sendMode = sendMode;
	}

	public int getSendStatus() {
		return sendStatus;
	}

	public void setSendStatus(int sendStatus) {
		this.sendStatus = sendStatus;
	}

	public String getSendTime() {
		return sendTime;
	}

	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
}
