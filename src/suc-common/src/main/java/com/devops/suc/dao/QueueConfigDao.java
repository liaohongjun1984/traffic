package com.devops.suc.dao;

import com.devops.suc.model.QueueConfig;

/**
 * 队列配置信息
 * @author wangxichun
 *
 */
public interface QueueConfigDao extends SqlMapper{
	
	/**
	 * 根据server_id取得配置
	 * @param server_id
	 * @return
	 */
	QueueConfig get(int server_id);
}
