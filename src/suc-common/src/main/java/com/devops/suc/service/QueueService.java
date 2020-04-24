package com.devops.suc.service;

import java.util.List;

import com.devops.suc.model.Queue;

/**
 * 队列
 * @author wangxichun
 *
 */
public interface QueueService {
	/**
	 * 增加 queue
	 * @param queue - queue 内容
	 * @return - 成功返回 queue id ( 大于 0)
	 */
	long addQueue(Queue queue);

	/**
	 * 获得最前的 count 个 queue
	 * @param threadIndex - 指示取哪个 queue 表的内容
	 * @param count - 个数
	 * @return Queue列表或 size=0 的 List
	 */
	List<Queue> getEarliestQueues(int threadIndex, int count);
	
	/**
	 * 删除一个 queue
	 * @param threadIndex - 指示删除哪个 queue 表的内容
	 * @param queueId - queue ID
	 */
	void deleteQueue(int threadIndex, long queueId);

}
