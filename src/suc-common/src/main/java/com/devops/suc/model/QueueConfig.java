package com.devops.suc.model;

import java.util.Date;

/**
 * 队列配置信息
 * @author wangxichun
 *
 */
public class QueueConfig {
	
	/**流水号*/
	private int server_id;
	
	/**队列索引，多个用","分开'*/
	private String queue_index;
	
	/**创建时间*/
	private Date create_time;
	
	/**创建管理员*/
	private String create_admin;

	public int getServer_id() {
		return server_id;
	}

	public void setServer_id(int serverId) {
		server_id = serverId;
	}

	public String getQueue_index() {
		return queue_index;
	}

	public void setQueue_index(String queueIndex) {
		queue_index = queueIndex;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date createTime) {
		create_time = createTime;
	}

	public String getCreate_admin() {
		return create_admin;
	}

	public void setCreate_admin(String createAdmin) {
		create_admin = createAdmin;
	}
	
}
