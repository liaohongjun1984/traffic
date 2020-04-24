package com.devops.suc.handler.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.devops.suc.dao.QueueDao;
import com.devops.suc.handler.QueueHandler;
import com.devops.suc.logic.queue.QueueStrategy;
import com.devops.suc.model.Queue;
import com.devops.suc.queue.ThreadChange;

/**
 * 队列
 * @author wangxichun
 *
 */
@Component("queueHandler")
public class QueueHandlerImpl implements QueueHandler{
	
	/** queue1Dao 表的 queue, Note: 不要直接使用，使用 getDao(queue) 函数获得 queue */
	@Autowired
	private QueueDao queue1Dao;
	
	/** queue2Dao 表的 queue, Note: 不要直接使用，使用 getDao(queue) 函数获得 queue */
	@Autowired
	private QueueDao queue2Dao;
	
	/** queue3Dao 表的 queue, Note: 不要直接使用，使用 getDao(queue) 函数获得 queue */
	@Autowired
	private QueueDao queue3Dao;

	/** queue4Dao 表的 queue, Note: 不要直接使用，使用 getDao(queue) 函数获得 queue */
	@Autowired
	private QueueDao queue4Dao;

	/** queue5Dao 表的 queue, Note: 不要直接使用，使用 getDao(job) 函数获得 dao */
	@Autowired
	private QueueDao queue5Dao;
	
	/** queue6Dao 表的 queue, Note: 不要直接使用，使用 getDao(job) 函数获得 dao */
	@Autowired
	private QueueDao queue6Dao;

	@Autowired
	private QueueStrategy queueStrategy;
	
	/**
	 * 获得处理 job 的 DAO
	 * @param index
	 * @return
	 */
	protected QueueDao getDao(int index) {
		if (index == 0) {
			return queue1Dao;
		}
		if (index == 1) {
			return queue2Dao;
		}
		if (index == 2) {
			return queue3Dao;
		}
		if (index == 3) {
			return queue4Dao;
		}
		if (index == 4) {
			return queue5Dao;
		}
		if (index == 5) {
			return queue6Dao;
		}
		return null;
	}
	
	@Override
	public long addQueue(Queue queue) {
		// 获得 dao
		int index = queueStrategy.getJobIndex();
		QueueDao dao = getDao(index);
		// 设置 job 数据变化
		ThreadChange.setNewQueueExecuteTime(index, queue.getExecute_time().getTime());
		
		dao.save(queue);
		long queueId = queue.getQueue_id();
		queue.setQueue_id(queueId);
		return queueId;
	}

	@Override
	public void batchAddQueue(List<Queue> lists) {
		// 检查参数是否合法
//		checNewkJob(job);
		// 获得 dao
//		int index = JobStrategy.getJobIndex(toolsId);
		int index = queueStrategy.getJobIndex();
		QueueDao dao = getDao(index);
//		// 设置 job 数据变化
		for(Queue queue:lists){
			ThreadChange.setNewQueueExecuteTime(index, queue.getExecute_time().getTime());
		}
		dao.batchSave(lists);
		
	}

	@Override
	public boolean deleteQueue(long queueId,int index) {
//		int index = queueStrategy.getJobIndex();
		// 获得 dao
		QueueDao dao = getDao(index);
		Queue queue = dao.get(queueId);
		if (queue != null) {
			// 设置 job 数据变化
			ThreadChange.setDeletedQueue(index, queue.getQueue_id());
			return dao.deleteQueue(queue.getQueue_id()) != 0;
		}
		return false;
	}

	@Override
	public List<Queue> listQueueByTime(int index, int limit) {
		// 获得 dao
		QueueDao dao = getDao(index);
		return dao.listQueue(limit);
	}

}
