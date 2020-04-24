package com.devops.suc.vo;

import com.idhoo.dhutil.vo.ActionBaseVO;

public class SendLogSearchVO extends ActionBaseVO {
	
	// 搜索起始时间
	private String start_time;
	// 搜索结束时间
	private String end_time;
	
	private int queue_type;

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

	public int getQueue_type() {
		return queue_type;
	}

	public void setQueue_type(int queue_type) {
		this.queue_type = queue_type;
	}
	
	

}
