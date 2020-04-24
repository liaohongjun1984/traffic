package com.devops.suc.dao;

import java.util.List;

import com.devops.suc.model.Queue;

/**
 * 信息通道队列
 * @author wangxichun
 *
 */
public interface QueueDao extends SqlMapper {
	
	/**
	 * 增加信息队列
	 * @param queue	--队列内容
	 */
	void save(Queue queue);
	
	/**
	 * 批量保存记录
	 * @param lists	--List<com.duowan.yy.sysop.suc.model.Queue>
	 * @return		--
	 */
	void batchSave(List<Queue> list);
	
	/**
	 * 队列总数
	 * @return
	 */
	int count();
	
	/**
	 * 获得 Queue 列表
	 *@param executeTime - 执行时间，在此时间之前的 queue 被返回
	 * @param limit - 限制最大返回的个数
	 * @return queue 列表或 size=0 的列表，列表排列顺序 execute_time (从低到高), queue_id (从小到大)
	 */
	List<Queue> listQueue(int limit);
	
	/**
	 * 删除 Queue
	 * @param queueId - queueId
	 * @return
	 */
	int deleteQueue(long queueId);
	
	/**
	 * 取得单个队列
	 * @param queueId
	 * @return
	 */
	Queue get(long queueId);
}
