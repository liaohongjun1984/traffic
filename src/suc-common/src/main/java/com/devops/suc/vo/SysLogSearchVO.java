package com.devops.suc.vo;

import com.idhoo.dhutil.vo.ActionBaseVO;

public class SysLogSearchVO extends ActionBaseVO {
	// 系统IP
	private int app_id;
	// 日志类型
	private int type;
	// 关键字content字段模糊搜索
	private String key;
	// 用户名模糊搜索
	private String nick_name;
	// 搜索起始时间
	private String start_time;
	// 搜索结束时间
	private String end_time;

	public String getStart_time() {
		return start_time;
	}

	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}

	public String getEnd_time() {
		return end_time;
	}

	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}

	public int getApp_id() {
		return app_id;
	}

	public void setApp_id(int app_id) {
		this.app_id = app_id;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getNick_name() {
		return nick_name;
	}

	public void setNick_name(String nick_name) {
		this.nick_name = nick_name;
	}
}
