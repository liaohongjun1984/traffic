package com.devops.suc.handler;

import java.util.List;

import com.devops.suc.model.Queue;

/**
 * 
 * @author wangxichun
 *
 */
public interface QueueHandler {

	/**
	 * 增加 Queue
	 * @param queue - Queue 内容
	 * @return - 成功返回 queue id ( 大于 0)
	 */
	long addQueue(Queue queue);
	
	/**
	 * 删除 queue
	 * @param queue - queue 参数，不能为 null
	 * @return true for success
	 */
	boolean deleteQueue(long queue_id,int index);
	
	
	/**
	 * 获得 queue 列表
	 * @param index -- 线程index
	 * @param limit -- 限制数量
	 * @return
	 */
	List<Queue> listQueueByTime(int index, int limit);
	
	/**
	 * 批量保存记录
	 * @param lists	--List<com.duowan.yy.sysop.suc.model.Queue>
	 * @return
	 */
	void batchAddQueue(List<Queue> lists);
}
