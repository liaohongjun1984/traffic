package com.devops.suc.model;

import java.io.Serializable;

public class TpDownloadStatistics{
	
	/** 自增长ID */
	private int id;
	
	/** 下载数 */
	private int download_num;
	
	/** 时间 */
	private String date;
	
	/** 操作人ID */
	private int user_id;
	
	/** 操作人name */
	private String user_name;
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public int getDownload_num() {
		return download_num;
	}
	
	public void setDownload_num(int download_num) {
		this.download_num = download_num;
	}
	
	public String getDate() {
		return date;
	}
	
	public void setDate(String date) {
		this.date = date;
	}
	
	public int getUser_id() {
		return user_id;
	}
	
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	
	public String getUser_name() {
		return user_name;
	}
	
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
}
